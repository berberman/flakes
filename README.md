# flakes

![CI](https://github.com/berberman/flakes/workflows/Update%20and%20check/badge.svg)

This repo adopts automatic update mechanism, where packages sources are defined in [Config.hs](./Config.hs).
The update script generates configuration file for [nvchecker](https://github.com/lilydjwg/nvchecker),
then calls it to find out if there are packages need to update. If so, it then uses [nix-prefetch](https://github.com/msteen/nix-prefetch)
to get SHA256 of source, storing it to [sums.json](./sums.json). Finally, it generates [sources.nix](./sources.nix), which is imported to the flake.

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
