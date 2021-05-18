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
      `sourceAur` "fcitx5-pinyin-zhwiki"
      `fetchUrl` \(coerce -> v) ->
        [trimming|https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.2/zhwiki-$v.dict|]
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
  writeFileChanged "README.md" $ T.unpack $ readmeTemplate $ T.unlines $ map ("* " <>) out
  putInfo "Generate README.md"
  where
    readmeTemplate rendered =
      [trimming|

          # flakes

          ![CI](https://github.com/berberman/flakes/workflows/Update%20and%20check/badge.svg)

          This repo uses [nvfetcher](https://github.com/berberman/nvfetcher) to update packages automatically.
          See [Update.hs](Update.hs).

          ## Usage

          Use binary cache from cachix:

          ```
          $ cachix use berberman
          ```

          ### Run a package immediately

          ```
          $ nix run github:berberman/flakes#feeluown
          ```

          ### Add the overlay to your system

          In your [NixOS configuration flake](https://www.tweag.io/blog/2020-07-31-nixos-flakes/):

          ```nix
          {
          
            inputs = {
              nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
              berberman = {
                url = "github:berberman/flakes";
                inputs.nixpkgs.follows = "nixpkgs";
              };
            };

            outputs = { self, nixpkgs, berberman }: {
            
              overlays = [ berberman.overlay ];

              # ... rest config
            };
          }
          ```

          ### NixOS CN

          Packages provided by this flake are re-exported to [NixOS CN Flakes](https://github.com/nixos-cn/flakes),
          so you can also use the CN flakes by following their instructions.

          ## Packages available

          #### This part was generated automatically.

          $rendered

    |]
