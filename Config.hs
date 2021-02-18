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
      `fetchUrl` (\_ -> "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf")
  -----------------------------------------------------------------------------
  -- def $ package "fastocr" `fromPypi` "fastocr"
  -----------------------------------------------------------------------------
  let defFuoPlugins = mapM_ $ \x ->
        def $
          package ("feeluown-" <> x)
            `fromPypi` ("fuo_" <> unPkgName x)

  def $ package "feeluown-core" `fromPypi` "feeluown"
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
  def $ package "python-baidu-aip" `fromPypi` "baidu-aip"
  -----------------------------------------------------------------------------
  -- def $
  --   package "new-pyside2"
  --     `sourceArchLinux` "pyside2"
  --     `fetchUrl` ( \(unVersion -> version) ->
  --                    "https://download.qt.io/official_releases/QtForPython/pyside2/PySide2-"
  --                      <> version
  --                      <> "-src/pyside-setup-opensource-src-"
  --                      <> version
  --                      <> ".tar.xz"
  --                )
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
      `sourceManual` "0.2.2" -- we don't update this package automatically
      `fetchGitHubFile` ( "felixonmars",
                          "fcitx5-pinyin-zhwiki",
                          "zhwiki-20210201.dict" -- since this file name changes each version
                        )
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
