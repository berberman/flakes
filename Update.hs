{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS_GHC -Wall #-}

import Control.Concurrent.Async (mapConcurrently)
import Control.Monad (void)
import qualified Data.Aeson as A
import qualified Data.HashMap.Strict as HMap
import qualified Data.Map.Merge.Strict as Map
import qualified Data.Map.Strict as Map
import Data.Maybe (catMaybes, fromMaybe)
import Data.Text (Text)
import qualified Data.Text as T
import Data.Text.Encoding (encodeUtf8)
import qualified Data.Text.IO as T
import NeatInterpolation (trimming)
import System.Process (CreateProcess, readCreateProcessWithExitCode, shell)
import qualified Toml
import Validation (Validation (Success))

-----------------------------------------------------------------------------

nvcheckerConfig :: FilePath
nvcheckerConfig = "nvchecker.toml"

sha256Data :: FilePath
sha256Data = "sha256sums.json"

-----------------------------------------------------------------------------

-- nvchecker.toml

data NvEntry = NvEntry
  { nvsource :: Text,
    nvpypi :: Maybe Text,
    nvgithub :: Maybe Text,
    nvmanual :: Maybe Text
  }
  deriving (Show)

nvEntryCodec :: Toml.Codec NvEntry NvEntry
nvEntryCodec =
  NvEntry
    <$> Toml.text "source" Toml..= nvsource
    <*> Toml.dioptional (Toml.text "pypi") Toml..= nvpypi
    <*> Toml.dioptional (Toml.text "github") Toml..= nvgithub
    <*> Toml.dioptional (Toml.text "manual") Toml..= nvmanual

decodeNvConfig :: Toml.TOML -> [(Text, NvEntry)]
decodeNvConfig toml = [(k, a) | (k, Success a) <- decoded]
  where
    list = HMap.toList $ Toml.tomlTables toml
    decoded = [(Toml.unPiece k, Toml.runTomlCodec nvEntryCodec a) | (k, Toml.Leaf _ a) <- list]

nvEntryToSource :: NvEntry -> Source
nvEntryToSource NvEntry {..} = case nvsource of
  "github" -> case nvgithub of
    Just (T.breakOn "/" -> (owner, T.uncons -> Just ('/', repo))) -> GitHub {..}
    _ -> error "github decode failure"
  "pypi" -> case nvpypi of
    Just pypi -> Pypi {..}
    _ -> error "pypi decode failure"
  "manual" -> case nvmanual of
    Just m -> Manual m
    _ -> error "manual decode failure"
  _ -> error "unsupported source type"

-----------------------------------------------------------------------------

-- nvchecker

data NvcheckerResult = NvcheckerResult
  { nvName :: Text,
    isUpToDate :: Bool
  }
  deriving (Eq, Show)

instance A.FromJSON NvcheckerResult where
  parseJSON = A.withObject "NvcheckerResult" $ \o ->
    NvcheckerResult <$> o A..: "name" <*> ((== A.String "up-to-date") <$> o A..: "event")

runNvchecker :: IO [NvcheckerResult]
runNvchecker = do
  txt <- runMyProcess . shell $ "nvchecker --logger json -c" <> nvcheckerConfig
  pure . catMaybes $ A.decodeStrict . encodeUtf8 <$> T.lines txt

runNvtake :: IO ()
runNvtake = void $ runMyProcess . shell $ "nvtake --all -c" <> nvcheckerConfig

decodeAsMap :: Maybe A.Value -> Map.Map Text Text
decodeAsMap (Just o) = case A.fromJSON o of
  A.Success x -> x
  A.Error e -> error e
decodeAsMap _ = error "failed to parse json"

-----------------------------------------------------------------------------

-- prefetch

sourceToFetcher :: Pkg -> Maybe Text -> Text
sourceToFetcher Pkg {..} mSha256 = case source of
  GitHub {..} -> fetchFromGitHubN owner repo version mSha256
  Pypi {..} -> fetchPypiN pypi version mSha256
  Manual m -> m

prefetchCommand :: Text -> CreateProcess
prefetchCommand template = shell $ "nix-prefetch '" <> T.unpack template <> "'"

prefetchPackage :: Pkg -> IO Text
prefetchPackage pkg@Pkg {..} = case source of
  Manual _ -> pure ""
  _ -> strip <$> runMyProcess (prefetchCommand $ sourceToFetcher pkg Nothing)
  where
    strip =
      ( \case
          (T.stripPrefix "sha256-" -> Just s) -> s
          _ -> error "failed to get sum"
      )
        . T.strip
        . last
        . T.lines

-----------------------------------------------------------------------------

data Source
  = GitHub {owner :: Text, repo :: Text}
  | Pypi {pypi :: Text}
  | Manual Text
  deriving (Show)

data Pkg = Pkg
  { name :: Text,
    source :: Source,
    version :: Text
  }
  deriving (Show)

-----------------------------------------------------------------------------
emptySha256 :: Text
emptySha256 = quoted "0000000000000000000000000000000000000000000000000000"

quoted :: Text -> Text
quoted x = [trimming|"$x"|]

fetchFromGitHubN :: Text -> Text -> Text -> Maybe Text -> Text
fetchFromGitHubN owner repo rev (fromMaybe emptySha256 -> sha256) =
  [trimming| 
    fetchFromGitHub {
      owner = "$owner";
      repo = "$repo";
      rev = "$rev";
      fetchSubmodules = true;
      sha256 = $sha256;
    }
  |]

fetchUrlN :: Text -> Maybe Text -> Text
fetchUrlN url (fromMaybe emptySha256 -> sha256) =
  [trimming|
    fetchurl {
      sha256 = $sha256;
      url = "$url";
    }
  |]

fetchPypiN :: Text -> Text -> Maybe Text -> Text
fetchPypiN pypi ver mSha256 =
  let h = T.cons (T.head pypi) ""
   in fetchUrlN [trimming|mirror://pypi/$h/$pypi/$pypi-$ver.tar.gz|] mSha256

fetchGitHubReleaseN :: Text -> Text -> Text -> Text -> Maybe Text -> Text
fetchGitHubReleaseN owner repo rev fp mSha256 =
  fetchUrlN [trimming|https://github.com/$owner/$repo/releases/download/$rev/$fp|] mSha256

snippetN :: Text -> Text -> Text -> Text
snippetN name ver src =
  [trimming|
    $name = {
      pname = "$name";
      version = "$ver";
      src = $src;
    };
  |]

fixedSN :: Text -> Text
fixedSN name = [trimming|sums.$name|]

sourcesN :: Text -> Text
sourcesN body =
  [trimming|
    # This file was generated by Update.hs, please do not modify it manually.
    { fetchFromGitHub, fetchurl }:
    let sums = with builtins; (fromJSON (readFile ./sha256sums.json));
    in {
      $body
    }
  |]

-----------------------------------------------------------------------------

merge' :: Ord k => (k -> a -> b -> c) -> Map.Map k a -> Map.Map k b -> Map.Map k c
merge' f =
  Map.merge
    Map.dropMissing
    Map.dropMissing
    (Map.zipWithMatched f)

main :: IO ()
main = do
  -- run nvchecker to generate new_ver.json
  T.putStrLn "Running nvchecker"
  ignoredNames <- fmap nvName . filter isUpToDate <$> runNvchecker

  T.putStr "The following packages are up-to-date: "
  T.putStrLn $ T.intercalate ", " ignoredNames

  T.putStrLn "Parsing nvchecker config"
  toml <- Toml.parse <$> T.readFile "nvchecker.toml"

  -- parse the config of nvchecker to generate fetchers
  let nvEntries = case toml of
        Right x -> Map.fromList $ decodeNvConfig x
        _ -> error "failed to parse nvchecker config"

  T.putStrLn "Parsing newver json"
  newVers <- decodeAsMap <$> A.decodeFileStrict' "new_ver.json"

  -- this is ugly, since we store sums again in another file
  T.putStrLn "Parsing sha256 json"
  recovered <- Map.filterWithKey (\k _ -> k `elem` ignoredNames) . decodeAsMap <$> A.decodeFileStrict' sha256Data

  -- ignore packages which don't need update
  let pkgs =
        Map.elems $
          merge'
            (\k x y -> Pkg {name = k, source = nvEntryToSource x, version = y})
            nvEntries
            newVers

  -- packages need feth
  T.putStr "Packages to fetch: "
  let needFetch = filter (\Pkg {..} -> name `notElem` ignoredNames) pkgs
  print needFetch

  -- run fetchers to get SHA256
  sha256sums <-
    mapConcurrently
      ( \pkg -> do
          result <- prefetchPackage pkg
          pure (pkg, result)
      )
      needFetch

  let sha256sumsWithRecovered = [(pkg, recovered Map.! name) | pkg@Pkg {..} <- pkgs, name `elem` ignoredNames] <> sha256sums

  T.putStrLn "Fetch result:"
  print sha256sums

  -- generate sources
  T.putStrLn "Generating sources.nix"

  let k =
        T.unlines
          [ snippetN name version fetcher
            | (pkg@Pkg {..}, _) <- sha256sumsWithRecovered,
              let fetcher = sourceToFetcher pkg . Just $ fixedSN name
          ]
  T.writeFile "sources.nix" $ sourcesN k

  -- update old_ver.json
  T.putStrLn "Running nvtake"
  runNvtake

  -- write all sums for next use
  A.encodeFile sha256Data $ Map.fromList $ fmap (\(Pkg {..}, sha256) -> (name, sha256)) sha256sumsWithRecovered

runMyProcess :: CreateProcess -> IO Text
runMyProcess c = do
  (_, stdout, stderr) <- readCreateProcessWithExitCode c ""
  putStrLn stdout
  putStrLn stderr
  pure $ T.pack stdout
