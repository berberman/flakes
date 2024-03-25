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
    version = "20240309";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20240309/moegirl.dict";
      sha256 = "sha256-ir9WQA2cz8VLL46/GaLTFAnL/H5vKWq3sbywHTcAKb8=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.4.20240210";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20240210.dict";
      sha256 = "sha256-vNHS5n3TqSwpUx2wG26w7rK6jSqrvLANeG2n0vA4iYk=";
    };
  };
  feeluown-bilibili = {
    pname = "feeluown-bilibili";
    version = "0.3.3";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown-bilibili/feeluown-bilibili-0.3.3.tar.gz";
      sha256 = "sha256-RnAaGH54CkYQMM4W6q4hTnMgzjWgDqMwKV4LS7sjkLA=";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "4.1.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown/feeluown-4.1.2.tar.gz";
      sha256 = "sha256-GBTDVzn9w4dfFtfn1fKC1JZkhcWwqe7lvvZcHASbzyE=";
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
    version = "1.0.1";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_netease/fuo_netease-1.0.1.tar.gz";
      sha256 = "sha256-tpGeP0EiPpu1WHDb2OCqE3YeKJQCWZeEirFR+4Sz5fk=";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "1.0.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_qqmusic/fuo_qqmusic-1.0.2.tar.gz";
      sha256 = "sha256-7Q23TbWMLN/kLs8Vdbe45zxi6IP0Wt+wxjzP/sEauqQ=";
    };
  };
  feeluown-ytmusic = {
    pname = "feeluown-ytmusic";
    version = "0.3.4";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo-ytmusic/fuo-ytmusic-0.3.4.tar.gz";
      sha256 = "sha256-6jpw+dB5yj9knjtU/VYJq7CCLyWtNd3UMFZLRubFDE4=";
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
    version = "0.51.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/pypinyin/pypinyin-0.51.0.tar.gz";
      sha256 = "sha256-zt40/DWnnvbHmfFh4sKA57Z1XuBy+3QcrlzipgxK4MU=";
    };
  };
  qbittorrent-enhanced = {
    pname = "qbittorrent-enhanced";
    version = "release-4.6.3.10";
    src = fetchFromGitHub {
      owner = "c0re100";
      repo = "qBittorrent-Enhanced-Edition";
      rev = "release-4.6.3.10";
      fetchSubmodules = false;
      sha256 = "sha256-O25sJmpyOwhtjrCbN4srKjcNDxEPHwX08MY+AM8QaCU=";
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
