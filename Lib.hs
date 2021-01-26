{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS_GHC -Wall #-}

module Lib where

import Control.Monad.State
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)
import Data.String (IsString (..))
import Data.Text (Text)
import qualified Data.Text as T
import Distribution.Compat.Lens
import NeatInterpolation (trimming)

emptySha256 :: Sha256
emptySha256 = quoted "0000000000000000000000000000000000000000000000000000"

quoted :: Text -> Text
quoted x = [trimming|"$x"|]

type Sha256 = Text

class ToNix a where
  toNix :: a -> Text

data NixFetcher
  = FetchFromGitHub Text Text Version (Maybe Sha256)
  | FetchUrl Text (Maybe Sha256)
  deriving (Show, Eq, Ord)

setSHA256 :: NixFetcher -> Maybe Sha256 -> NixFetcher
setSHA256 (FetchFromGitHub owner repo version _) mSha256 = FetchFromGitHub owner repo version mSha256
setSHA256 (FetchUrl url _) mSha256 = FetchUrl url mSha256

instance ToNix NixFetcher where
  toNix (FetchFromGitHub owner repo (unVersion -> rev) (fromMaybe emptySha256 -> sha256)) =
    [trimming| 
      fetchFromGitHub {
        owner = "$owner";
        repo = "$repo";
        rev = "$rev";
        fetchSubmodules = true;
        sha256 = $sha256;
      }
    |]
  toNix (FetchUrl url (fromMaybe emptySha256 -> sha256)) =
    [trimming|
      fetchurl {
        sha256 = $sha256;
        url = "$url";
      }
    |]

data NvcheckerSource = GitHub {owner :: Text, repo :: Text} | Pypi {pypi :: Text} | Manual Version

type SourceName = Text

toNvEntry :: SourceName -> NvcheckerSource -> Text
toNvEntry srcName GitHub {..} =
  [trimming|
    [$srcName]
    source = "github"
    github = "$owner/$repo"
    use_latest_release = true
  |]
toNvEntry srcName Pypi {..} =
  [trimming|
    [$srcName]
    source = "pypi"
    pypi = "$pypi"
  |]
toNvEntry srcName (Manual (unVersion -> v)) =
  [trimming|
    [$srcName]
    source = "manual"
    manual = "$v"
  |]

newtype PkgName = PkgName {unPkgName :: Text}
  deriving (Eq, Show, Ord, IsString, Semigroup, Monoid)

newtype Version = Version {unVersion :: Text}
  deriving (Eq, Show, Ord, IsString, Semigroup, Monoid)

data Pkg = Pkg
  { pkgName :: PkgName,
    fetcher :: NixFetcher
  }
  deriving (Show, Eq, Ord)

data DefState = DefState
  { _pkgs :: Map Pkg SourceName,
    _sources :: Map SourceName NvcheckerSource,
    _srcCount :: Int
  }

pkgs :: Lens' DefState (Map Pkg SourceName)
pkgs f s = fmap (\x -> s {_pkgs = x}) (f (_pkgs s))

sources :: Lens' DefState (Map SourceName NvcheckerSource)
sources f s = fmap (\x -> s {_sources = x}) (f (_sources s))

srcCount :: Lens' DefState Int
srcCount f s = fmap (\x -> s {_srcCount = x}) (f (_srcCount s))

-- will be expanded after running nvchecker
attatchedVer :: Version
attatchedVer = "$src"

-- for DSL
fixedVer :: Text -> Version
fixedVer = Version

type Definition = State DefState

runDefinition :: Definition a -> DefState
runDefinition = flip execState (DefState Map.empty Map.empty 0)

-----------------------------------------------------------------------------

newFixedSource :: Version -> Definition SourceName
newFixedSource = newSource . Manual

newSource :: NvcheckerSource -> Definition SourceName
newSource source = do
  count <- use srcCount
  newSource' ("src-" <> T.pack (show $ succ count)) source

newSource' :: SourceName -> NvcheckerSource -> Definition SourceName
newSource' srcName source = do
  sources %= Map.insert srcName source
  srcCount %= succ
  pure srcName

attatchTo :: SourceName -> Pkg -> Definition ()
attatchTo srcName pkg = pkgs %= Map.insert pkg srcName

latestGitHub :: PkgName -> (Text, Text) -> Definition ()
latestGitHub name (owner, repo) = do
  src <- newSource' (unPkgName name) $ GitHub owner repo
  src `attatchTo` Pkg name (FetchFromGitHub owner repo attatchedVer Nothing)

latestPypi :: PkgName -> Text -> Definition ()
latestPypi name pypi = do
  src <- newSource' (unPkgName name) $ Pypi pypi
  let h = T.cons (T.head pypi) ""
      ver = unVersion attatchedVer
  src `attatchTo` Pkg name (FetchUrl [trimming|mirror://pypi/$h/$pypi/$pypi-$ver.tar.gz|] Nothing)

-- for DSL
package :: Text -> PkgName
package = PkgName

-- for infix
hasPypiName :: PkgName -> Text -> Definition ()
hasPypiName = latestPypi

-- for DSL
hasGitHubRepo :: PkgName -> (Text, Text) -> Definition ()
hasGitHubRepo = latestGitHub

githubReleaseFile :: PkgName -> (Text, Text) -> SourceName -> Text -> Definition ()
githubReleaseFile name (owner, repo) src fp = do
  let ver' = unVersion attatchedVer
  src `attatchTo` Pkg name (FetchUrl [trimming|https://github.com/$owner/$repo/releases/download/$ver'/$fp|] Nothing)

-----------------------------------------------------------------------------
