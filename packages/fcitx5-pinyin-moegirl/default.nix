{ stdenv, lib, mySource }:

let dic = "moegirl.dict";
in stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -D -m644 $src $out/share/fcitx5/pinyin/dictionaries/${dic}
  '';

  meta = with lib; {
    homepage = "https://github.com/outloudvi/mw2fcitx";
    description = "Fcitx 5 pinyin dictionary of zh.moegirl.org.cn";
    license = licenses.unlicense;
  };
}
