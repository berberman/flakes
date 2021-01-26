# This file was generated by Update.hs, please do not modify it manually.
{ fetchFromGitHub, fetchurl }:
let sums = with builtins; (fromJSON (readFile ./sha256sums.json));
in {
  fcitx5-pinyin-moegirl = {
    pname = "fcitx5-pinyin-moegirl";
    version = "20210114";
    src = fetchurl {
      sha256 = sums.fcitx5-pinyin-moegirl;
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20210114/moegirl.dict";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.2";
    src = fetchurl {
      sha256 = sums.fcitx5-pinyin-zhwiki;
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.2/zhwiki-20210101.dict";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "3.7";
    src = fetchurl {
      sha256 = sums.feeluown-core;
      url = "mirror://pypi/f/feeluown/feeluown-3.7.tar.gz";
    };
  };
  feeluown-kuwo = {
    pname = "feeluown-kuwo";
    version = "0.1.2";
    src = fetchurl {
      sha256 = sums.feeluown-kuwo;
      url = "mirror://pypi/f/fuo_kuwo/fuo_kuwo-0.1.2.tar.gz";
    };
  };
  feeluown-local = {
    pname = "feeluown-local";
    version = "0.2.1";
    src = fetchurl {
      sha256 = sums.feeluown-local;
      url = "mirror://pypi/f/fuo_local/fuo_local-0.2.1.tar.gz";
    };
  };
  feeluown-netease = {
    pname = "feeluown-netease";
    version = "0.5";
    src = fetchurl {
      sha256 = sums.feeluown-netease;
      url = "mirror://pypi/f/fuo_netease/fuo_netease-0.5.tar.gz";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "0.3.1";
    src = fetchurl {
      sha256 = sums.feeluown-qqmusic;
      url = "mirror://pypi/f/fuo_qqmusic/fuo_qqmusic-0.3.1.tar.gz";
    };
  };
  pypinyin = {
    pname = "pypinyin";
    version = "0.40.0";
    src = fetchurl {
      sha256 = sums.pypinyin;
      url = "mirror://pypi/p/pypinyin/pypinyin-0.40.0.tar.gz";
    };
  };
  qasync = {
    pname = "qasync";
    version = "0.13.0";
    src = fetchurl {
      sha256 = sums.qasync;
      url = "mirror://pypi/q/qasync/qasync-0.13.0.tar.gz";
    };
  };
  qliveplayer = {
    pname = "qliveplayer";
    version = "3.21.1";
    src = fetchFromGitHub {
      owner = "IsoaSFlus";
      repo = "QLivePlayer";
      rev = "3.21.1";
      fetchSubmodules = true;
      sha256 = sums.qliveplayer;
    };
  };
}