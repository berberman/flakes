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

* [apple-emoji](https://github.com/samuelngs/apple-emoji-linux) - v18.4
* [fcitx5-material-color](https://github.com/hosxy/Fcitx5-Material-Color) - 0.2.1
* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx) - 20260109
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki) - 0.3.0.20251223
* [feeluown](https://github.com/feeluown/FeelUOwn) - 4.1.16
* [feeluown-bilibili](https://github.com/feeluown/feeluown-bilibili) - 0.5.3
* [feeluown-core](https://github.com/feeluown/FeelUOwn) - 4.1.16
* [feeluown-kuwo](https://github.com/feeluown/feeluown-kuwo) - 0.2.2
* [feeluown-netease](https://github.com/feeluown/feeluown-netease) - 1.0.6
* [feeluown-qqmusic](https://github.com/feeluown/feeluown-qqmusic) - 1.0.14
* [feeluown-ytmusic](https://github.com/feeluown/feeluown-ytmusic) - 0.4.13
* [luoxu](https://github.com/lilydjwg/luoxu) - a46c8435428f94116d6164d8fcd6226c5126c0a5
* [luoxu-cutwords](https://github.com/lilydjwg/luoxu) - a46c8435428f94116d6164d8fcd6226c5126c0a5
* [pypinyin](https://github.com/mozillazg/python-pinyin) - 0.55.0
