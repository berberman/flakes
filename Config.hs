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
  fcitx5NordSource <- newSource' (sourceName fcitx5Nord) $ Manual "28ada26f4e926a741d8645cb8fa9d9d8ab3a3b70"
  fcitx5NordSource `attatchTo` Pkg (package fcitx5Nord) (FetchFromGitHub "tonyfettes" fcitx5Nord attatchedVer Nothing)
