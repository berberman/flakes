{ stdenv, lib, mySource }:

let dic = "zhwiki-20210101.dict";
in stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -D -m644 $src $out/share/fcitx5/pinyin/dictionaries/zhwiki.dict
  '';

  meta = with lib; {
    homepage = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki";
    description = "Fcitx 5 Pinyin Dictionary from zh.wikipedia.org";
    license = licenses.unlicense;
  };
}
