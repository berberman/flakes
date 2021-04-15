{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}

module Config (nixSources) where

import Control.Monad.IO.Class (liftIO)
import Updater.Lib

nixSources :: Definition ()
nixSources = do
  def $
    package "apple-emoji"
      `sourceManual` "0.0.0.20200413"
      `fetchUrl` const "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf"
  -----------------------------------------------------------------------------
  def $ package "fastocr" `fromPypi` "fastocr"
  -----------------------------------------------------------------------------
  let defFuoPlugins = mapM_ $ \x ->
        def $
          package ("feeluown-" <> x)
            `fromPypi` ("fuo_" <> unPkgName x)

  -- https://github.com/NixOS/nixpkgs/issues/119284
  def $ package "feeluown-core" `sourceManual` "3.7.5" `fetchPypi` "feeluown"
  -- def $ package "feeluown-core" `fromPypi` "feeluown"
  defFuoPlugins
    [ "kuwo",
      "netease",
      "qqmusic",
      "local",
      "xiami"
    ]
  -----------------------------------------------------------------------------
  def $ package "pypinyin" `fromPypi` "pypinyin"
  -----------------------------------------------------------------------------
  def $ package "qasync" `fromPypi` "qasync"
  -----------------------------------------------------------------------------
  def $ package "qliveplayer" `fromGitHub` ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  def $
    package "fcitx5-pinyin-moegirl"
      `sourceGitHub` ("outloudvi", "mw2fcitx")
      `fetchGitHubFile` ( "outloudvi",
                          "mw2fcitx",
                          "moegirl.dict"
                        )
  -----------------------------------------------------------------------------
  def $
    package "fcitx5-pinyin-zhwiki"
      `sourceAur` "fcitx5-pinyin-zhwiki"
      `fetchUrl` (\v -> "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.2/zhwiki-" <> unVersion v <> ".dict")
  -----------------------------------------------------------------------------
  -- this is evil :(
  nordRev <- liftIO $ extractCommitRevFromPKGBUILD <$> downloadArchPKGBUILD "fcitx5-nord"
  def $
    package "fcitx5-nord"
      `sourceArchLinux` "fcitx5-nord"
      `fetchGitHubByRev` ("tonyfettes", "fcitx5-nord", nordRev)
  -----------------------------------------------------------------------------
  -- and again...
  materialRev <- liftIO $ extractCommitRevFromPKGBUILD <$> downloadArchPKGBUILD "fcitx5-material-color"
  def $
    package "fcitx5-material-color"
      `sourceArchLinux` "fcitx5-material-color"
      `fetchGitHubByRev` ("hosxy", "fcitx5-material-color", materialRev)
