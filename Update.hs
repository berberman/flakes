{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ViewPatterns #-}

module Update (main) where

import Control.Monad (unless)
import qualified Data.Aeson as A
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as T
import Development.Shake
import NeatInterpolation (trimming)
import NvFetcher

main :: IO ()
main = runNvFetcher defaultArgs {argActionAfterBuild = generateReadme >> processAutoCommit} packageSet

packageSet :: PackageSet ()
packageSet = do
  -----------------------------------------------------------------------------
  define $
    package "apple-emoji"
      `sourceManual` "0.0.0.20200413"
        `fetchUrl` const
          "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf"
  -----------------------------------------------------------------------------
  define $ package "fastocr" `fromPypi` "fastocr"
  -----------------------------------------------------------------------------
  define $ package "feeluown-core" `fromPypi` "feeluown"
  let fuoPlugins = mapM_ $ \x -> define $ package ("feeluown-" <> x) `fromPypi` ("fuo_" <> x)
  fuoPlugins ["kuwo", "netease", "qqmusic", "local"]
  -----------------------------------------------------------------------------
  define $ package "pypinyin" `fromPypi` "pypinyin"
  -----------------------------------------------------------------------------
  define $ package "qasync" `fromPypi` "qasync"
  -----------------------------------------------------------------------------
  define $ package "qliveplayer" `fromGitHub` ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  define $
    package "fcitx5-pinyin-moegirl"
      `sourceGitHub` ("outloudvi", "mw2fcitx")
      `fetchGitHubRelease` ("outloudvi", "mw2fcitx", "moegirl.dict")
  -----------------------------------------------------------------------------
  define $
    package "fcitx5-pinyin-zhwiki"
      `sourceArchLinux` "fcitx5-pinyin-zhwiki"
      -- drop "0.2.3."
      `fetchUrl` \(T.drop 6 . coerce -> v) ->
        [trimming|https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.3/zhwiki-$v.dict|]
  -----------------------------------------------------------------------------
  define $ package "fcitx5-material-color" `fromGitHub` ("hosxy", "fcitx5-material-color")

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
  template <- T.pack <$> readFile' "READNE_template.md"
  writeFileChanged "README.md" $ T.unpack $ T.replace "$qwq$" (T.unlines $ map ("* " <>) out) template
  putInfo "Generate README.md"
