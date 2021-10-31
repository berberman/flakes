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
* [fastocr](https://github.com/BruceZhang1993/FastOCR) - 0.3.0
* [fcitx5-material-color](https://github.com/hosxy/Fcitx5-Material-Color) - 0.2.1
* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx) - 20211014
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki) - 0.2.3.20211016
* [feeluown](https://github.com/feeluown/FeelUOwn) - 3.7.12
* [feeluown-core](https://github.com/feeluown/FeelUOwn) - 3.7.12
* [feeluown-kuwo](https://github.com/feeluown/feeluown-kuwo) - 0.1.4
* [feeluown-local](https://github.com/feeluown/feeluown-local) - 0.2.1
* [feeluown-netease](https://github.com/feeluown/feeluown-netease) - 0.7.1
* [feeluown-qqmusic](https://github.com/feeluown/feeluown-qqmusic) - 0.3.3
* [pypinyin](https://github.com/mozillazg/python-pinyin) - 0.43.0
* [qasync](https://github.com/CabbageDevelopment/qasync) - 0.22.0
* [qbittorrent-enhanced](https://github.com/c0re100/qBittorrent-Enhanced-Edition) - 4.3.9.10
* [qliveplayer](https://github.com/IsoaSFlus/QLivePlayer) - 3.22.4

