# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  apple-emoji = {
    pname = "apple-emoji";
    version = "0.0.0.20200413";
    src = fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/alpha-release-v1.0.0/AppleColorEmoji.ttf";
      sha256 = "sha256-j1xml01ucZi7f9aRhAKo4doval5q/ohsxK+flYSkTHU=";
    };
  };
  fastocr = {
    pname = "fastocr";
    version = "0.3.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fastocr/fastocr-0.3.0.tar.gz";
      sha256 = "sha256-bCsHfnuEG29TLBrbuqPu4Nc/g4ikKGTy94/gtA429kg=";
    };
  };
  fcitx5-material-color = {
    pname = "fcitx5-material-color";
    version = "0.2.1";
    src = fetchFromGitHub ({
      owner = "hosxy";
      repo = "fcitx5-material-color";
      rev = "0.2.1";
      fetchSubmodules = false;
      sha256 = "sha256-i9JHIJ+cHLTBZUNzj9Ujl3LIdkCllTWpO1Ta4OT1LTc=";
    });
  };
  fcitx5-pinyin-moegirl = {
    pname = "fcitx5-pinyin-moegirl";
    version = "20220114";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20220114/moegirl.dict";
      sha256 = "sha256-8aXieXe4DwTsW1SeCIG3JO4NA4s6kziO1kShTXkv108=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.3.20220127";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.3/zhwiki-20220127.dict";
      sha256 = "sha256-m51c64hW0Inr6WEelHfsJgivMEBuAVHNzpRWZVQYMEs=";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "3.8.2";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/feeluown/feeluown-3.8.2.tar.gz";
      sha256 = "sha256-V2yzpkmjRkipZOvQGB2mYRhiiEly6QPrTOMJ7BmyWBQ=";
    };
  };
  feeluown-kuwo = {
    pname = "feeluown-kuwo";
    version = "0.1.5";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_kuwo/fuo_kuwo-0.1.5.tar.gz";
      sha256 = "sha256-1Umad7glnyO7l+Pu0dfPQkIkM8lT4Q5Z4JQqPUxge1M=";
    };
  };
  feeluown-local = {
    pname = "feeluown-local";
    version = "0.3";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_local/fuo_local-0.3.tar.gz";
      sha256 = "sha256-7Qgi9nGxmic3nq6icWUC7pQjyF6Gj91TAH5RyrvMI7Y=";
    };
  };
  feeluown-netease = {
    pname = "feeluown-netease";
    version = "0.8";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_netease/fuo_netease-0.8.tar.gz";
      sha256 = "sha256-C1eHG2V+qe+ub4OUfLVrumO31kQugr8xb8WBMmsg9LU=";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "0.4";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_qqmusic/fuo_qqmusic-0.4.tar.gz";
      sha256 = "sha256-gnBKk+X0ejP+qo5FLG60Tv8wv3VxoJqDgb9ghMBipLc=";
    };
  };
  pypinyin = {
    pname = "pypinyin";
    version = "0.45.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/p/pypinyin/pypinyin-0.45.0.tar.gz";
      sha256 = "sha256-d2Q5JEogxzhkJc6ze1pps24cRpygVQ9EI8mQD0T1E0s=";
    };
  };
  qasync = {
    pname = "qasync";
    version = "0.23.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/q/qasync/qasync-0.23.0.tar.gz";
      sha256 = "sha256-iWXsMT4BBxSNmOisHnenfc503jzZcFWhqmLVE6N5OhQ=";
    };
  };
  qbittorrent-enhanced = {
    pname = "qbittorrent-enhanced";
    version = "release-4.4.0.10";
    src = fetchFromGitHub ({
      owner = "c0re100";
      repo = "qBittorrent-Enhanced-Edition";
      rev = "release-4.4.0.10";
      fetchSubmodules = false;
      sha256 = "sha256-XAH2KS+fkRe+c23calgfNWBygWlMBgx5U8RA+ZfxNqQ=";
    });
  };
  qliveplayer = {
    pname = "qliveplayer";
    version = "4.1.1";
    src = fetchFromGitHub ({
      owner = "THMonster";
      repo = "QLivePlayer";
      rev = "4.1.1";
      fetchSubmodules = true;
      sha256 = "sha256-qhFcUzTV4F6UVP14XuEYp4KWalQwnMBItA7J8rzyHNY=";
    });
    cargoLock = {
      lockFile = ./qliveplayer-4.1.1/src/QLivePlayer-Lib/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
}
