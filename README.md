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
    # Add as an input
    berberman = {
      url = "github:berberman/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, berberman }: {
    nixosConfigurations.my-machine = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        # ...
        { nixpkgs.overlays = [ 
            # ...
            # Add to nixpkgs overlays
            berberman.overlays.default
          ]; 
        }
      ];
    };
  };
}
```

## Packages available

* [apple-emoji](https://github.com/samuelngs/apple-emoji-linux) - v16.4-patch.1
* [fastocr](https://github.com/BruceZhang1993/FastOCR) - 0.3.7
* [fcitx5-material-color](https://github.com/hosxy/Fcitx5-Material-Color) - 0.2.1
* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx) - 20231114
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki) - 0.2.4.20231205
* [feeluown](https://github.com/feeluown/FeelUOwn) - 3.8.15
* [feeluown-bilibili](https://github.com/feeluown/feeluown-bilibili) - 0.3.1
* [feeluown-core](https://github.com/feeluown/FeelUOwn) - 3.8.15
* [feeluown-kuwo](https://github.com/feeluown/feeluown-kuwo) - 0.2.2
* [feeluown-netease](https://github.com/feeluown/feeluown-netease) - 1.0
* [feeluown-qqmusic](https://github.com/feeluown/feeluown-qqmusic) - 1.0.1
* [feeluown-ytmusic](https://github.com/feeluown/feeluown-ytmusic) - 0.3.3
* [luoxu](https://github.com/lilydjwg/luoxu) - a46c8435428f94116d6164d8fcd6226c5126c0a5
* [luoxu-cutwords](https://github.com/lilydjwg/luoxu) - a46c8435428f94116d6164d8fcd6226c5126c0a5
* [py-term](https://github.com/gravmatt/py-term) - 0.7
* [pypinyin](https://github.com/mozillazg/python-pinyin) - 0.50.0
* [qbittorrent-enhanced](https://github.com/c0re100/qBittorrent-Enhanced-Edition) - 4.6.3.10
* [zydra](https://github.com/hamedA2/Zydra) - 791fabd188adcb1fd1cd8c53288b424740114cf9
