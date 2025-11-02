{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ViewPatterns #-}

module Update (main) where

import Control.Monad (unless)
import qualified Data.Aeson as A
import Data.Default (def)
import Data.Map (Map)
import Data.Maybe (fromJust)
import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as T
import Development.Shake
import NeatInterpolation (trimming)
import NvFetcher
import NvFetcher.Config (Config (actionAfterBuild))

main :: IO ()
main = runNvFetcher' def {actionAfterBuild = generateReadme >> processAutoCommit} packageSet

packageSet :: PackageSet ()
packageSet = do
  -----------------------------------------------------------------------------
  define $ package "apple-emoji"
             `sourceGitHub` ("samuelngs", "apple-emoji-linux")
             `fetchGitHubRelease` ("samuelngs", "apple-emoji-linux", "AppleColorEmoji.ttf")
  -----------------------------------------------------------------------------
  define $ package "fastocr" `fromPypi` "fastocr"
  -----------------------------------------------------------------------------
  define $ package "feeluown-core" `fromPypi` "feeluown"
  let fuoPlugins = mapM_ $ \x -> define $ package ("feeluown-" <> x) `fromPypi` ("fuo_" <> x)
  fuoPlugins ["netease", "qqmusic"]
  define $ package "feeluown-bilibili" `sourcePypi` "feeluown-bilibili" `fetchPypi` "feeluown_bilibili"
  define $ package "feeluown-ytmusic" `fetchPypi` "fuo_ytmusic" `sourcePypi` "fuo-ytmusic"
  define $ package "feeluown-kuwo" `fromPypi` "fuo-kuwo"
  -----------------------------------------------------------------------------
  define $ package "pypinyin" `fromPypi` "pypinyin"
  -----------------------------------------------------------------------------
  define $ package "qbittorrent-enhanced" `fromGitHub` ("c0re100", "qBittorrent-Enhanced-Edition")
  -----------------------------------------------------------------------------
  -- define $ package "qliveplayer" `fromGitHub'` ("THMonster", "QLivePlayer", fetchSubmodules .~ True) `hasCargoLock` "src/QLivePlayer-Lib/Cargo.lock"
  -----------------------------------------------------------------------------
  define $
    package "fcitx5-pinyin-moegirl"
      `sourceGitHub` ("outloudvi", "mw2fcitx")
      `fetchGitHubRelease` ("outloudvi", "mw2fcitx", "moegirl.dict")
  -----------------------------------------------------------------------------
  define $
    package "fcitx5-pinyin-zhwiki"
      `sourceArchLinux` "fcitx5-pinyin-zhwiki"
      `fetchUrl` \(coerce -> v) ->
        let dictVer =  T.takeWhileEnd (/= '.') v
            converterVer = fromJust $ T.stripSuffix ("." <> dictVer) v
        in
        [trimming|https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/$converterVer/zhwiki-$dictVer.dict|]
  -----------------------------------------------------------------------------
  define $ package "fcitx5-material-color" `fromGitHub` ("hosxy", "fcitx5-material-color")
  -----------------------------------------------------------------------------
  define $
    package "luoxu" 
      `sourceManual` "a46c8435428f94116d6164d8fcd6226c5126c0a5"
      `fetchGitHub` ("lilydjwg", "luoxu")
      `hasCargoLocks` ["querytrans/Cargo.lock", "luoxu-cutwords/Cargo.lock"]

processAutoCommit :: Action ()
processAutoCommit =
  getEnv "GITHUB_ENV" >>= \case
    Just env -> do
      changes <- getVersionChanges
      liftIO $
        unless (null changes) $
          appendFile env $
            "COMMIT_MSG<<EOF\n"
              <> case show <$> changes of
                [x] -> x <> "\n"
                xs -> "Auto update:\n" <> unlines xs
              <> "EOF\n"
    _ -> pure ()

generateReadme :: Action ()
generateReadme = do
  -- we need use generated files in flakes
  command [] "git" ["add", "."] :: Action ()
  (A.decode @(Map Text Text) -> Just (Map.elems -> out)) <-
    fromStdout
      <$> command
        []
        "nix"
        [ "eval",
          "./#packages.x86_64-linux",
          "--apply",
          T.unpack [trimming|with builtins; mapAttrs (key: value: "[$${key}](${value.meta.homepage or ""}) - ${value.version}")|],
          "--json"
        ]
  template <- T.pack <$> readFile' "README_template.md"
  writeFileChanged "README.md" $ T.unpack $ template <> "\n" <> (T.unlines $ map ("* " <>) out) 
  putInfo "Generate README.md"
