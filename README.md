# flakes

![CI](https://github.com/berberman/flakes/workflows/Update%20and%20check/badge.svg)

This repo adopts automatic update mechanism, where packages sources are defined in [Config.hs](./Config.hs).
The update script generates configuration file for [nvchecker](https://github.com/lilydjwg/nvchecker),
and then consults it to find outdated packages, feeding them to [nix-prefetch](https://github.com/msteen/nix-prefetch)
to recalculate SHA256 sums. The results will be dumped to [sums.json](./sums.json),
and corresponding nix exprs will be written to [sources.nix](./sources.nix).

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

* apple-emoji - 0.0.0.20200413
* fastocr - 0.1.4
* fcitx5-material-color - 0.0.0.20201212
* fcitx5-nord - 0.0.0.20210116
* fcitx5-pinyin-moegirl - 20210318
* fcitx5-pinyin-zhwiki - 20210301
* feeluown-core - 3.7.5
* feeluown-kuwo - 0.1.2
* feeluown-local - 0.2.1
* feeluown-netease - 0.5
* feeluown-qqmusic - 0.3.1
* feeluown-xiami - 0.2.4
* pypinyin - 0.41.0
* qasync - 0.14.0
* qliveplayer - 3.22.0
