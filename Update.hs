{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ViewPatterns #-}

module Update (main) where

import Control.Monad.IO.Class (liftIO)
import qualified Data.Aeson as A
import Data.Coerce (coerce)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as T
import Development.NvFetcher
import Development.Shake
import NeatInterpolation (trimming)

main :: IO ()
main = defaultMain defaultArgs {argRules = rules} packageSet

packageSet :: PackageSet ()
packageSet = do
  -----------------------------------------------------------------------------
  package "apple-emoji" (Manual "0.0.0.20200413") $
    const $ urlFetcher "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf"
  -----------------------------------------------------------------------------
  pypiPackage "fastocr" "fastocr"
  -----------------------------------------------------------------------------
  pypiPackage "feeluown-core" "feeluown"
  let fuoPlugins = mapM_ $ \x -> pypiPackage ("feeluown-" <> x) ("fuo_" <> x)
  fuoPlugins ["kuwo", "netease", "qqmusic", "local", "xiami"]
  -----------------------------------------------------------------------------
  pypiPackage "pypinyin" "pypinyin"
  -----------------------------------------------------------------------------
  pypiPackage "qasync" "qasync"
  -----------------------------------------------------------------------------
  gitHubPackage "qliveplayer" ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  package
    "fcitx5-pinyin-moegirl"
    (GitHubRelease "outloudvi" "mw2fcitx")
    (gitHubReleaseFetcher ("outloudvi", "mw2fcitx") "moegirl.dict")
  -----------------------------------------------------------------------------
  package
    "fcitx5-pinyin-zhwiki"
    (Aur "fcitx5-pinyin-zhwiki")
    ( \(coerce -> v) ->
        urlFetcher
          [trimming|https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.2/zhwiki-$v.dict|]
    )
  -----------------------------------------------------------------------------
  gitHubPackage "fcitx5-material-color" ("hosxy", "fcitx5-material-color")

-- | Add a rule to generate README.md in our build system
rules :: Rules ()
rules =
  "README.md" %> \fp -> do
    -- always rerun is important
    alwaysRerun
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
    writeFileChanged fp $ T.unpack $ readmeTemplate $ T.unlines $ map ("* " <>) out
    putInfo $ "Generate " <> fp
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
