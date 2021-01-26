{-# LANGUAGE OverloadedStrings #-}

module Config (nixSources) where

import Lib

nixSources :: Definition ()
nixSources = do
  -----------------------------------------------------------------------------
  package "feeluown-core" `hasPypiName` "feeluown"
  let fuoPlugins xs = sequence_ [latestPypi ("feeluown-" <> x) ("fuo_" <> unPkgName x) | x <- xs]
  fuoPlugins ["kuwo", "netease", "qqmusic", "local"]
  -----------------------------------------------------------------------------
  package "pypinyin" `hasPypiName` "pypinyin"
  -----------------------------------------------------------------------------
  package "qasync" `hasPypiName` "qasync"
  -----------------------------------------------------------------------------
  package "qliveplayer" `hasGitHubRepo` ("IsoaSFlus", "QLivePlayer")
  -----------------------------------------------------------------------------
  let moegirlDicRepo = ("outloudvi", "mw2fcitx")
      moegirlDicPkgName = "fcitx5-pinyin-moegirl"
  moegirlDicSource <- newSource' moegirlDicPkgName $ uncurry GitHub moegirlDicRepo
  githubReleaseFile (package moegirlDicPkgName) moegirlDicRepo moegirlDicSource "moegirl.dict"
  -----------------------------------------------------------------------------
  -- we don't update this package automatically, since the file name of dictionary changes each version
  let zhwikiDicRepo = ("felixonmars", "fcitx5-pinyin-zhwiki")
      zhwikiDicPkgName = "fcitx5-pinyin-zhwiki"
  zhwikiDicSource <- newSource' zhwikiDicPkgName $ Manual "0.2.2"
  githubReleaseFile (package zhwikiDicPkgName) ("felixonmars", "fcitx5-pinyin-zhwiki") zhwikiDicSource "zhwiki-20210101.dict"
