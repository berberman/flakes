{-# LANGUAGE OverloadedStrings #-}

module Config (nixSources) where

import Updater.Lib

nixSources :: Definition ()
nixSources = do
  -----------------------------------------------------------------------------
  package "feeluown-core" `hasPypiName` "feeluown"
  let fuoPlugins = mapM_ $ \x -> package ("feeluown-" <> x) `hasPypiName` ("fuo_" <> x)
  fuoPlugins ["kuwo", "netease", "qqmusic", "local", "xiami"]
  -----------------------------------------------------------------------------
  package "pypinyin" `hasPypiName` "pypinyin"
  -----------------------------------------------------------------------------
  package "qasync" `hasPypiName` "qasync"
  -----------------------------------------------------------------------------
  package "qliveplayer" `hasGitHubRepo` ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  let moegirlDicRepo = ("outloudvi", "mw2fcitx")
      moegirlDic = "fcitx5-pinyin-moegirl"
  moegirlDicSource <- newSource' (sourceName moegirlDic) $ uncurry GitHub moegirlDicRepo
  githubReleaseFile (package moegirlDic) moegirlDicRepo moegirlDicSource "moegirl.dict"
  -----------------------------------------------------------------------------
  -- we don't update this package automatically, since the file name of dictionary changes each version
  let zhwikiDicRepo = ("felixonmars", "fcitx5-pinyin-zhwiki")
      zhwikiDic = "fcitx5-pinyin-zhwiki"
  zhwikiDicSource <- newSource' (sourceName zhwikiDic) $ Manual "0.2.2"
  githubReleaseFile (package zhwikiDic) zhwikiDicRepo zhwikiDicSource "zhwiki-20210101.dict"
  -----------------------------------------------------------------------------
  let fcitx5Nord = "fcitx5-nord"
  fcitx5NordSource <- newSource' (sourceName fcitx5Nord) $ Manual "0.0.0.20210116"
  fcitx5NordSource
    `attatchTo` Pkg
      (package fcitx5Nord)
      (FetchFromGitHub "tonyfettes" fcitx5Nord "28ada26f4e926a741d8645cb8fa9d9d8ab3a3b70" Nothing)
  -----------------------------------------------------------------------------
  let fcitx5MaterialColor = "fcitx5-material-color"
  fcitx5MaterialColorSource <- newSource' (sourceName fcitx5MaterialColor) $ Manual "0.0.0.20201212"
  fcitx5MaterialColorSource
    `attatchTo` Pkg
      (package fcitx5MaterialColor)
      (FetchFromGitHub "hosxy" fcitx5MaterialColor "c5f240591af52a041ff0fcde6fe245761c926f61" Nothing)
