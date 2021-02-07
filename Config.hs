{-# LANGUAGE OverloadedStrings #-}

module Config (nixSources) where

import Updater.Lib

nixSources :: Definition ()
nixSources = do
  -----------------------------------------------------------------------------
  def $ package "feeluown-core" `fromPypi` "feeluown"
  let fuoPlugins = mapM_ $ \x ->
        def $ package ("feeluown-" <> x) `fromPypi` ("fuo_" <> unPkgName x)
  fuoPlugins ["kuwo", "netease", "qqmusic", "local", "xiami"]
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
      `fetchGitHubFile` ("outloudvi", "mw2fcitx", "moegirl.dict")
  -----------------------------------------------------------------------------
  -- we don't update this package automatically
  -- since the file name of dictionary changes each version
  def $
    package "fcitx5-pinyin-zhwiki"
      `sourceManual` "0.2.2"
      `fetchGitHubFile` ("felixonmars", "fcitx5-pinyin-zhwiki", "zhwiki-20210101.dict")
  -----------------------------------------------------------------------------
  -- the version number is from archlinux
  -- we don't update this automatically because we don't know the git rev behind this version
  def $
    package "fcitx5-nord"
      `sourceManual` "0.0.0.20210116" -- just for display, we don't use this to fetch
      `fetchGitHubByRev` ("tonyfettes", "fcitx5-nord", "28ada26f4e926a741d8645cb8fa9d9d8ab3a3b70")
  -----------------------------------------------------------------------------
  -- the version number is from archlinux
  -- we don't update this automatically because we don't know the git rev behind this version
  def $
    package "fcitx5-material-color"
      `sourceManual` "0.0.0.20201212" -- just for display, we don't use this to fetch
      `fetchGitHubByRev` ("hosxy", "fcitx5-material-color", "c5f240591af52a041ff0fcde6fe245761c926f61")
