# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
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
    version = "20230714";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20230714/moegirl.dict";
      sha256 = "sha256-E8K25uRIwZEN8iX8o7Sy9lNBm8WfqJYYSs50ReeiMFk=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.4.20230605";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20230605.dict";
      sha256 = "sha256-G44bgOWpnQEbP78idcOobEUm2m+7cYM+UCqyJu+D+9E=";
    };
  };
  feeluown-bilibili = {
    pname = "feeluown-bilibili";
    version = "0.2.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown_bilibili/feeluown_bilibili-0.2.0.tar.gz";
      sha256 = "sha256-yknHFfcKP7Y4BtLReLmxCROaTIEtWKWg8euHgze4Om0=";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "3.8.12";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/feeluown/feeluown-3.8.12.tar.gz";
      sha256 = "sha256-KP0mIAgYY86XRR7z+uYATB0NeKwHXNUgK09xQ0xyPoo=";
    };
  };
  feeluown-kuwo = {
    pname = "feeluown-kuwo";
    version = "0.2.1";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo-kuwo/fuo-kuwo-0.2.1.tar.gz";
      sha256 = "sha256-WrpYlvDeFdDXQZ3Qx6XuG7t9Rkg08u4AiMM24B7gRR8=";
    };
  };
  feeluown-netease = {
    pname = "feeluown-netease";
    version = "0.9.7";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_netease/fuo_netease-0.9.7.tar.gz";
      sha256 = "sha256-CU14UsGFp0Ux4sgvQXQSAs5CDsRf2nmmp4Zwjan1SHw=";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "0.5.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo_qqmusic/fuo_qqmusic-0.5.0.tar.gz";
      sha256 = "sha256-angjPGzJqVvvS3He5ql+8lvuUPwxnJ1NmLA/6byEMTE=";
    };
  };
  feeluown-ytmusic = {
    pname = "feeluown-ytmusic";
    version = "0.3.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/f/fuo-ytmusic/fuo-ytmusic-0.3.0.tar.gz";
      sha256 = "sha256-nAP5jyKM7DNFsQ0+VVYXcM1fsi91XH2NjUmRyit3HCI=";
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
    version = "0.49.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/pypinyin/pypinyin-0.49.0.tar.gz";
      sha256 = "sha256-pdYaecX0j2tKQi8BDCDUj81TxwV4TfSqgOMpSTIZpL4=";
    };
  };
  qasync = {
    pname = "qasync";
    version = "0.24.0";
    src = fetchurl {
      url = "https://pypi.org/packages/source/q/qasync/qasync-0.24.0.tar.gz";
      sha256 = "sha256-5YPRw64g/RLpCN7jWMUncJtIDnjVf7cu5XqUCXMH2Vk=";
    };
  };
  qbittorrent-enhanced = {
    pname = "qbittorrent-enhanced";
    version = "release-4.5.4.10";
    src = fetchFromGitHub {
      owner = "c0re100";
      repo = "qBittorrent-Enhanced-Edition";
      rev = "release-4.5.4.10";
      fetchSubmodules = false;
      sha256 = "sha256-2kHjW3CMcAEITbYzw8QNRqkTWrMkaktkdAd69moyk2M=";
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
