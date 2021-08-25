# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl }:
{
  apple-emoji = {
    pname = "apple-emoji";
    version = "0.0.0.20200413";
    src = fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/latest/AppleColorEmoji.ttf";
      sha256 = "0xaclj29b7xgqin8izkabrm2znp1m01894fngyxrhwbf9nbncp4g";
    };
  };
  fastocr = {
    pname = "fastocr";
    version = "0.3.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fastocr/fastocr-0.3.0.tar.gz";
      sha256 = "0j7n6q7b9q4gyzr68a54i21kzmz0xsivmnqs5i9ny6w4gdz0favc";
    };
  };
  fcitx5-material-color = {
    pname = "fcitx5-material-color";
    version = "0.2.1";
    src = fetchgit {
      url = "https://github.com/hosxy/fcitx5-material-color";
      rev = "0.2.1";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0drdypjf1njl7flkb5d581vchwlp4gaqyws3cp0v874wkwh4gllb";
    };
  };
  fcitx5-pinyin-moegirl = {
    pname = "fcitx5-pinyin-moegirl";
    version = "20210815";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20210815/moegirl.dict";
      sha256 = "04dpqhrvlqalzf7zxafnbly39h9q54xd13p95x3vplnjwkfikp9g";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "0.2.3.20210823";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.3/zhwiki-20210823.dict";
      sha256 = "1kys7nhnavvmaaw32rpyh10n1p892nyz5k2rx30fv44cbimb2mdk";
    };
  };
  feeluown-core = {
    pname = "feeluown-core";
    version = "3.7.10";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/feeluown/feeluown-3.7.10.tar.gz";
      sha256 = "0yr7xqaf7bb8xg2hdphgii6pmlnrpadhhmzns6aw591l469xgpmp";
    };
  };
  feeluown-kuwo = {
    pname = "feeluown-kuwo";
    version = "0.1.4";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_kuwo/fuo_kuwo-0.1.4.tar.gz";
      sha256 = "1knflrhipadmqqsgs9cysp1hn9lx58q2x00bd1lrbm16nq1ngcyr";
    };
  };
  feeluown-local = {
    pname = "feeluown-local";
    version = "0.2.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_local/fuo_local-0.2.1.tar.gz";
      sha256 = "0ifl2d5qwx0cyh6i1c952ldwwzdcwzbj98fxx2b8dky3wlla96d7";
    };
  };
  feeluown-netease = {
    pname = "feeluown-netease";
    version = "0.7.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_netease/fuo_netease-0.7.1.tar.gz";
      sha256 = "0yzhbpwlsg3n8q21xfd8hfnf7fc9pcv69kqdypij3xpdrfadvcpg";
    };
  };
  feeluown-qqmusic = {
    pname = "feeluown-qqmusic";
    version = "0.3.3";
    src = fetchurl {
      url = "https://pypi.io/packages/source/f/fuo_qqmusic/fuo_qqmusic-0.3.3.tar.gz";
      sha256 = "0gwcg8xc0nxk5dl6f2kl2mzi0fr70qdrv29fk151pikg3hmh5i3l";
    };
  };
  pypinyin = {
    pname = "pypinyin";
    version = "0.42.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/p/pypinyin/pypinyin-0.42.0.tar.gz";
      sha256 = "18fkl6hagg6w8pz48r6af9pqvnz6fdq7zrf783a3h8xx0frh7w62";
    };
  };
  qasync = {
    pname = "qasync";
    version = "0.19.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/q/qasync/qasync-0.19.0.tar.gz";
      sha256 = "0vaffxv0wsxrgm327hdb4akv44nh9bpwa4jkp82bvq92f8wn9k7b";
    };
  };
  qbittorrent-enhanced = {
    pname = "qbittorrent-enhanced";
    version = "release-4.3.7.10";
    src = fetchgit {
      url = "https://github.com/c0re100/qBittorrent-Enhanced-Edition";
      rev = "release-4.3.7.10";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "1s4b1bg8n476y0pkq80zrbihgf2vbsd2dawckp1xagj598aa2fmv";
    };
  };
  qliveplayer = {
    pname = "qliveplayer";
    version = "3.22.4";
    src = fetchgit {
      url = "https://github.com/IsoaSFlus/QLivePlayer";
      rev = "3.22.4";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0nd8f7ixwrpdkwq3dz8891xnbm4ss2scmkz5v29s2gfk2kgdmilq";
    };
  };
}
