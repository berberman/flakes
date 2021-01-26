# flakes

![Auto update](https://github.com/berberman/flakes/workflows/Auto%20update/badge.svg)
![Check flake](https://github.com/berberman/flakes/workflows/Check%20flake/badge.svg)

This repo adopts automatic update mechanism, where packages sources are defined in [Config.hs](./Config.hs).
The update script generates configuration file of [nvchecker](https://github.com/lilydjwg/nvchecker),
then calls it to find out if there are packages need to update. If so, it then uses [nix-prefetch](https://github.com/msteen/nix-prefetch)
to get SHA256 of source, storing it to [sha256sums.json](./sha256sums.json). Finally, it generates [sources.nix](./sources.nix), which is imported to the flake.

#### packages available:

* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx)
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)
* [feeluown](https://github.com/feeluown/FeelUOwn)
* [qliveplayer](https://github.com/IsoaSFlus/QLivePlayer)
