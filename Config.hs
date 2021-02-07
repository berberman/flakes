{-# LANGUAGE OverloadedStrings #-}

module Config (nixSources) where

import Control.Monad.IO.Class (liftIO)
import Updater.Lib

nixSources :: Definition ()
nixSources = do
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
                          "zhwiki-20210101.dict" -- since this file name changes each version
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
