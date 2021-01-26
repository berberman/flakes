{-# LANGUAGE OverloadedStrings #-}

module Config (nixSources) where

import Lib

nixSources :: Definition ()
nixSources = do
  -----------------------------------------------------------------------------
  package "feeluown-core" `hasPypiName` "feeluown"
  let fuoPlugins xs = sequence_ [latestPypi ("feeluown-" <> x) ("fuo_" <> unPkgName x) | x <- xs]
   in fuoPlugins ["kuwo", "netease", "qqmusic", "local"]
  -----------------------------------------------------------------------------
  package "pypinyin" `hasPypiName` "pypinyin"
  -----------------------------------------------------------------------------
  package "qasync" `hasPypiName` "qasync"
  -----------------------------------------------------------------------------
  package "qliveplayer" `hasGitHubRepo` ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  let moegirlDicRepo = ("outloudvi", "mw2fcitx")
  moegirlDicSource <- newSource $ uncurry GitHub moegirlDicRepo
  githubReleaseFile "fcitx5-pinyin-moegirl" moegirlDicRepo moegirlDicSource "moegirl.dict"
  -----------------------------------------------------------------------------
  -- we use manual version here since the file name of dictionary changes each version
  zhwikiDicSource <- newSource $ Manual "0.2.2"
  githubReleaseFile "fcitx5-pinyin-zhwiki" ("felixonmars", "fcitx5-pinyin-zhwiki") zhwikiDicSource "zhwiki-20210101.dict"
