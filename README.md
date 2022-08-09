# flakes

[![Automatically update](https://github.com/berberman/flakes/actions/workflows/nvfetcher.yaml/badge.svg)](https://github.com/berberman/flakes/actions/workflows/nvfetcher.yaml)

This repo uses [nvfetcher](https://github.com/berberman/nvfetcher) to update packages automatically.
See [Update.hs](Update.hs).

## Usage

Use binary cache from cachix:

```
$ cachix use berberman
```

### Run a package immediately

```
$ nix run github:berberman/flakes#feeluown
```

### Add the overlay to your system

In your [NixOS configuration flake](https://www.tweag.io/blog/2020-07-31-nixos-flakes/):

```nix
{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    berberman = {
      url = "github:berberman/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, berberman }: {
  
    overlays = [ berberman.overlay ];

    # ... rest config
  };
}
```

### NixOS CN

Packages provided by this flake are re-exported to [NixOS CN Flakes](https://github.com/nixos-cn/flakes),
so you can also use the CN flakes by following their instructions.

## Packages available

#### This part was generated automatically.

* [apple-emoji](https://github.com/samuelngs/apple-emoji-linux) - 0.0.0.20200413
* [fastocr](https://github.com/BruceZhang1993/FastOCR) - 0.3.7
* [fcitx5-material-color](https://github.com/hosxy/Fcitx5-Material-Color) - 0.2.1
* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx) - 20220218
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki) - 0.2.4.20220722
* [feeluown](https://github.com/feeluown/FeelUOwn) - 3.8.8
* [feeluown-core](https://github.com/feeluown/FeelUOwn) - 3.8.8
* [feeluown-kuwo](https://github.com/feeluown/feeluown-kuwo) - 0.1.6
* [feeluown-local](https://github.com/feeluown/feeluown-local) - 0.3
* [feeluown-netease](https://github.com/feeluown/feeluown-netease) - 0.9.2
* [feeluown-qqmusic](https://github.com/feeluown/feeluown-qqmusic) - 0.4.1
* [py-term](https://github.com/gravmatt/py-term) - 0.7
* [pypinyin](https://github.com/mozillazg/python-pinyin) - 0.47.0
* [qasync](https://github.com/CabbageDevelopment/qasync) - 0.23.0
* [qbittorrent-enhanced](https://github.com/c0re100/qBittorrent-Enhanced-Edition) - 4.4.3.12
* [zydra](https://github.com/hamedA2/Zydra) - 791fabd188adcb1fd1cd8c53288b424740114cf9

