{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS_GHC -Wall #-}

module Updater.Lib where

import Control.Monad.State
import Data.Aeson (FromJSON, FromJSONKey, ToJSON, ToJSONKey)
import Data.ByteString.Lazy (toStrict)
import Data.Functor ((<&>))
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)
import Data.String (IsString (..))
import Data.Text (Text)
import qualified Data.Text as T
import Data.Text.Encoding (decodeUtf8)
import Distribution.Compat.Lens
import NeatInterpolation (trimming)
import Network.HTTP.Client (Response (responseBody), httpLbs, parseRequest)
import Network.HTTP.Client.TLS (getGlobalManager)

downloadArchPKGBUILD :: Text -> IO Text
downloadArchPKGBUILD pkg = do
  tlsManager <- getGlobalManager
  req <- parseRequest $ T.unpack [trimming|https://raw.githubusercontent.com/archlinux/svntogit-community/packages/$pkg/trunk/PKGBUILD|]
  res <- httpLbs req tlsManager
  pure . decodeUtf8 . toStrict $ responseBody res

-- unsafe
extractCommitRevFromPKGBUILD :: Text -> Text
extractCommitRevFromPKGBUILD txt = head [rev | (T.stripPrefix "_commit=" -> Just rev) <- T.lines txt]

emptySha256 :: Sha256
emptySha256 = "lib.fakeSha256"

type Sha256 = Text

class ToNix a where
  toNix :: a -> Text

data NixFetcher
  = FetchFromGitHub Text Text Version (Maybe Sha256)
  | FetchUrl Text (Maybe Sha256)
  deriving (Show, Eq, Ord)

setSHA256 :: NixFetcher -> Maybe Sha256 -> NixFetcher
setSHA256 (FetchFromGitHub owner repo version _) mSha256 = FetchFromGitHub owner repo version mSha256
setSHA256 (FetchUrl url _) mSha256 = FetchUrl url mSha256

instance ToNix NixFetcher where
  toNix (FetchFromGitHub owner repo (unVersion -> rev) (fromMaybe emptySha256 -> sha256)) =
    [trimming| 
      fetchFromGitHub {
        owner = "$owner";
        repo = "$repo";
        rev = "$rev";
        fetchSubmodules = true;
        sha256 = $sha256;
      }
    |]
  toNix (FetchUrl url (fromMaybe emptySha256 -> sha256)) =
    [trimming|
      fetchurl {
        sha256 = $sha256;
        url = "$url";
      }
    |]

data NvcheckerSource
  = GitHub {owner :: Text, repo :: Text}
  | Pypi {pypi :: Text}
  | ArchLinux {archpkg :: Text}
  | Manual {manual :: Version}

toNvEntry :: SourceName -> NvcheckerSource -> Text
toNvEntry (unSourceName -> srcName) = \case
  GitHub {..} ->
    [trimming|
      [$srcName]
      source = "github"
      github = "$owner/$repo"
      use_latest_release = true
    |]
  ArchLinux {..} ->
    [trimming|
      [$srcName]
      source = "archpkg"
      archpkg = "$archpkg"
      strip_release = true
    |]
  Pypi {..} ->
    [trimming|
      [$srcName]
      source = "pypi"
      pypi = "$pypi"
    |]
  Manual {..} ->
    let v = unVersion manual
     in [trimming|
          [$srcName]
          source = "manual"
          manual = "$v"
        |]

newtype PkgName = PkgName {unPkgName :: Text}
  deriving (Eq, Show, Ord, IsString, Semigroup, Monoid)

newtype Version = Version {unVersion :: Text}
  deriving (Eq, Show, Ord, IsString, Semigroup, Monoid)

newtype SourceName = SourceName {unSourceName :: Text}
  deriving (Eq, Show, Ord, IsString, Semigroup, Monoid)
  deriving (FromJSON, ToJSON, FromJSONKey, ToJSONKey) via Text

data Pkg = Pkg
  { pkgName :: PkgName,
    fetcher :: NixFetcher
  }
  deriving (Show, Eq, Ord)

data DefState = DefState
  { _pkgs :: Map Pkg SourceName,
    _sources :: Map SourceName NvcheckerSource,
    _srcCount :: Int
  }

pkgs :: Lens' DefState (Map Pkg SourceName)
pkgs f s = fmap (\x -> s {_pkgs = x}) (f (_pkgs s))

sources :: Lens' DefState (Map SourceName NvcheckerSource)
sources f s = fmap (\x -> s {_sources = x}) (f (_sources s))

srcCount :: Lens' DefState Int
srcCount f s = fmap (\x -> s {_srcCount = x}) (f (_srcCount s))

-- will be expanded after running nvchecker
attatchedVer :: Version
attatchedVer = "$src"

type Definition = StateT DefState IO

runDefinition :: Definition a -> IO DefState
runDefinition = flip execStateT (DefState Map.empty Map.empty 0)

-----------------------------------------------------------------------------

newFixedSource :: Version -> Definition SourceName
newFixedSource = newSource . Manual

newSource :: NvcheckerSource -> Definition SourceName
newSource source = do
  count <- use srcCount
  newSource' ("src-" <> SourceName (T.pack (show $ succ count))) source

newSource' :: SourceName -> NvcheckerSource -> Definition SourceName
newSource' srcName source = do
  sources %= Map.insert srcName source
  srcCount %= succ
  pure srcName

attatchTo :: SourceName -> Pkg -> Definition ()
attatchTo srcName pkg = pkgs %= Map.insert pkg srcName

pypiFetcher :: Text -> Version -> NixFetcher
pypiFetcher pypi (unVersion -> ver) =
  let h = T.cons (T.head pypi) ""
   in FetchUrl [trimming|mirror://pypi/$h/$pypi/$pypi-$ver.tar.gz|] Nothing

githubReleaseFetcher :: (Text, Text) -> Text -> Version -> NixFetcher
githubReleaseFetcher (owner, repo) fp (unVersion -> ver) =
  FetchUrl [trimming|https://github.com/$owner/$repo/releases/download/$ver/$fp|] Nothing

-----------------------------------------------------------------------------

newtype EPkg = EPkg PkgName

data EFetch a = EFetch (Version -> NixFetcher) a

data ESrc a = ESrc NvcheckerSource a

class HasPkg a where
  getPkgName :: a -> PkgName

instance HasPkg EPkg where
  getPkgName (EPkg x) = x

instance (HasPkg a) => HasPkg (EFetch a) where
  getPkgName (EFetch _ x) = getPkgName x

instance (HasPkg a) => HasPkg (ESrc a) where
  getPkgName (ESrc _ x) = getPkgName x

class HasFetch a where
  getFetch :: a -> Version -> NixFetcher

instance HasFetch (EFetch a) where
  getFetch (EFetch x _) = x

instance (HasFetch a) => HasFetch (ESrc a) where
  getFetch (ESrc _ x) = getFetch x

class HasSrc a where
  getSrc :: a -> NvcheckerSource

instance HasSrc (ESrc a) where
  getSrc (ESrc x _) = x

instance (HasSrc a) => HasSrc (EFetch a) where
  getSrc (EFetch _ x) = getSrc x

class Sem r where
  package :: PkgName -> r EPkg
  fetch :: r a -> (Version -> NixFetcher) -> r (EFetch a)
  src :: r a -> NvcheckerSource -> r (ESrc a)
  end :: (HasPkg a, HasFetch a, HasSrc a) => r a -> r ()

  fetchPypi :: r a -> Text -> r (EFetch a)
  fetchPypi e name = fetch e $ pypiFetcher name
  sourcePypi :: r a -> Text -> r (ESrc a)
  sourcePypi e name = src e $ Pypi name
  fromPypi :: r a -> Text -> r (ESrc (EFetch a))
  fromPypi e name = sourcePypi (fetchPypi e name) name

  fetchGitHubByRev :: r a -> (Text, Text, Text) -> r (EFetch a)
  fetchGitHubByRev e (owner, repo, rev) = fetch e $ \_ -> FetchFromGitHub owner repo (Version rev) Nothing
  fetchGitHub :: r a -> (Text, Text) -> r (EFetch a)
  fetchGitHub e (owner, repo) = fetch e $ \v -> FetchFromGitHub owner repo v Nothing
  fetchGitHubFile :: r a -> (Text, Text, Text) -> r (EFetch a)
  fetchGitHubFile e (owner, repo, fp) = fetch e $ githubReleaseFetcher (owner, repo) fp
  sourceGitHub :: r a -> (Text, Text) -> r (ESrc a)
  sourceGitHub e (owner, repo) = src e $ GitHub owner repo
  fromGitHub :: r a -> (Text, Text) -> r (ESrc (EFetch a))
  fromGitHub e s = sourceGitHub (fetchGitHub e s) s

  fetchUrl :: r a -> (Version -> Text) -> r (EFetch a)
  fetchUrl e f = fetch e $ \v -> FetchUrl (f v) Nothing

  sourceArchLinux :: r a -> Text -> r (ESrc a)
  sourceArchLinux e s = src e $ ArchLinux s
  sourceManual :: r a -> Version -> r (ESrc a)
  sourceManual e ver = src e $ Manual ver

newtype R a = R {unR :: Definition a}

instance Sem R where
  package = R . pure . EPkg
  fetch e f = R $ unR e <&> EFetch f
  src e s = R $ unR e <&> ESrc s
  end e = R $ do
    x <- unR e
    let p = getPkgName x
        s = getSrc x
        f = getFetch x
    srcName <- newSource' (SourceName $ unPkgName p) s
    srcName `attatchTo` Pkg p (f attatchedVer)

def :: (HasPkg a, HasFetch a, HasSrc a) => R a -> Definition ()
def = unR . end
