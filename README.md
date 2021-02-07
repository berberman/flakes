# flakes

![CI](https://github.com/berberman/flakes/workflows/Update%20and%20check/badge.svg)

This repo adopts automatic update mechanism, where packages sources are defined in [Config.hs](./Config.hs).
The update script generates configuration file for [nvchecker](https://github.com/lilydjwg/nvchecker),
and then calls it to find outoutdated packages, feeding them to [nix-prefetch](https://github.com/msteen/nix-prefetch),
storing fetched SHA256 sums to [sums.json](./sums.json). Finally, it generates [sources.nix](./sources.nix), which is imported to the flake.

#### packages available:

* [fcitx5-material-color](https://github.com/hosxy/Fcitx5-Material-Color)
* [fcitx5-nord](https://github.com/tonyfettes/fcitx5-nord)
* [fcitx5-pinyin-moegirl](https://github.com/outloudvi/mw2fcitx)
* [fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)
* [feeluown](https://github.com/feeluown/FeelUOwn)
  * [feeluown-kuwo](https://github.com/feeluown/feeluown-kuwo)
  * [feeluown-local](https://github.com/feeluown/feeluown-local)
  * [feeluown-netease](https://github.com/feeluown/feeluown-netease)
  * [feeluown-qqmusic](https://github.com/feeluown/feeluown-qqmusic)
  * [feeluown-xiami](https://github.com/feeluown/feeluown-xiami)
* [qasync](https://github.com/CabbageDevelopment/qasync)
* [qliveplayer](https://github.com/IsoaSFlus/QLivePlayer)
