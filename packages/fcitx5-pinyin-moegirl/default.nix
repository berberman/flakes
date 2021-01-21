{ stdenv, lib, fetchurl }:

let dic = "moegirl.dict";
in stdenv.mkDerivation rec {
  pname = "fcitx5-pinyin-moegirl";
  version = "20210114";

  src = fetchurl {
    url =
      "https://github.com/outloudvi/mw2fcitx/releases/download/${version}/${dic}";
    sha256 = "sha256-HZabFVvobT7QnKIak+cyILOHIWhdfxNmpPyLrnD4nGo=";
  };

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
