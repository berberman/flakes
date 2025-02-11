# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  apple-emoji = {
    pname = "apple-emoji";
    version = "v17.4";
    src = fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
      sha256 = "sha256-SG3JQLybhY/fMX+XqmB/BKhQSBB0N1VRqa+H6laVUPE=";
    };
  };
  fastocr = {
    pname = "fastocr";
    version = "0.3.7";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fastocr/fastocr-0.3.7.tar.gz";
      sha256 = "sha256-jOvWmKWwrBfq/2+XqKaaeavfNn7OAcsn6bB6ZCfNukM=";
    };
  };
  fcitx5-material-color = {
    pname = "fcitx5-material-color";
    version = "0.2.1";
    src = fetchFromGitHub {
      owner = "hosxy";
      repo = "fcitx5-material-color";
      rev = "0.2.1";
      fetchSubmodules = false;
      sha256 = "sha256-i9JHIJ+cHLTBZUNzj9Ujl3LIdkCllTWpO1Ta4OT1LTc=";
    };
  };
  fcitx5-pinyin-moegirl = {
    pname = "fcitx5-pinyin-moegirl";
    version = "20250209";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20250209/moegirl.dict";
      sha256 = "sha256-+EIXBIu3OE59VpnAWalmiNqD4FsvuSgRr79OQCqrgMA=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.5.20241218";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.5/zhwiki-20241218.dict";
      sha256 = "sha256-9Z+dgicQQdsySn1/xn6w4Q4hOqMv7Rngol615/JxtRk=";
    };
  };
  feeluown-bilibili = {
    pname = "feeluown-bilibili";
    version = "0.5.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown-bilibili/feeluown-bilibili-0.5.0.tar.gz";
      sha256 = "sha256-Xgm8q16hs38mdqtAf5aGxZ3N+ExyvIJRb80J9kUleZk=";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "4.1.9";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown/feeluown-4.1.9.tar.gz";
      sha256 = "sha256-ieFjYKg5u1U6rgOeI022ZW0TTo3fSKH/KEj2xf/Tp1w=";
    };
  };
  feeluown-kuwo = {
    pname = "feeluown-kuwo";
    version = "0.2.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo-kuwo/fuo-kuwo-0.2.2.tar.gz";
      sha256 = "sha256-hUcW9nVl5z00FpAF9x5qLn7NWjSQURCmDZWQBTXglpU=";
    };
  };
  feeluown-netease = {
    pname = "feeluown-netease";
    version = "1.0.3";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_netease/fuo_netease-1.0.3.tar.gz";
      sha256 = "sha256-ISmAewcBijl29YSojmA7aO+P6HUy2/1wu0OE8BgoLBg=";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "1.0.5";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_qqmusic/fuo_qqmusic-1.0.5.tar.gz";
      sha256 = "sha256-8hwKvmgbcZIkfQ5DZ7z39VcqM/+kfVUqvBRyj3nVTkE=";
    };
  };
  feeluown-ytmusic = {
    pname = "feeluown-ytmusic";
    version = "0.4.9";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo-ytmusic/fuo-ytmusic-0.4.9.tar.gz";
      sha256 = "sha256-LqCzGBA00DuCwC1pch9mVU9V0rqrHWDHKuLa5Sh7ov0=";
    };
  };
  luoxu = {
    pname = "luoxu";
    version = "a46c8435428f94116d6164d8fcd6226c5126c0a5";
    src = fetchFromGitHub {
      owner = "lilydjwg";
      repo = "luoxu";
      rev = "a46c8435428f94116d6164d8fcd6226c5126c0a5";
      fetchSubmodules = false;
      sha256 = "sha256-lNmXnORDjcCecpz/16ggamVF/8RHjsoz37kKTxjMYkU=";
    };
    cargoLock."querytrans/Cargo.lock" = {
      lockFile = ./luoxu-a46c8435428f94116d6164d8fcd6226c5126c0a5/querytrans/Cargo.lock;
      outputHashes = {
        
      };
    };
    cargoLock."luoxu-cutwords/Cargo.lock" = {
      lockFile = ./luoxu-a46c8435428f94116d6164d8fcd6226c5126c0a5/luoxu-cutwords/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  py-term = {
    pname = "py-term";
    version = "0.7";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/py-term/py-term-0.7.tar.gz";
      sha256 = "sha256-q6pNGsEnzMbdUNGTensDD1on6jvZOvNr7COu79BdUMk=";
    };
  };
  pypinyin = {
    pname = "pypinyin";
    version = "0.53.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/pypinyin/pypinyin-0.53.0.tar.gz";
      sha256 = "sha256-otOd3CvTG1WJe7sQ0uEaDE05mYipfACtSJwVGv2bEG0=";
    };
  };
  qbittorrent-enhanced = {
    pname = "qbittorrent-enhanced";
    version = "release-5.0.3.10";
    src = fetchFromGitHub {
      owner = "c0re100";
      repo = "qBittorrent-Enhanced-Edition";
      rev = "release-5.0.3.10";
      fetchSubmodules = false;
      sha256 = "sha256-efQFjdJeVMrPvCQ5aYtUb65hozKc73MnP0/Kheti9BI=";
    };
  };
  zydra = {
    pname = "zydra";
    version = "791fabd188adcb1fd1cd8c53288b424740114cf9";
    src = fetchFromGitHub {
      owner = "hamedA2";
      repo = "Zydra";
      rev = "791fabd188adcb1fd1cd8c53288b424740114cf9";
      fetchSubmodules = false;
      sha256 = "sha256-6yHPlinmbg3M7Yun+fn34LJY1xggZy9mAgwRDgRZf9Y=";
    };
    date = "2020-07-22";
  };
}
