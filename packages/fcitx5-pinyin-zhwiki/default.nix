{ stdenv, lib, fetchurl, ... }:

let dic = "zhwiki-20210101.dict";
in stdenv.mkDerivation rec {
  pname = "fcitx5-pinyin-zhwiki";
  version = "0.2.2";

  src = fetchurl {
    url =
      "https://github.com/felixonmars/${pname}/releases/download/${version}/${dic}";
    sha256 = "HCwQ7RekneUXqXfYmRiJ93CX+Oscn8gmAU+sIKqYJwQ=";
  };

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -D -m644 $src -t $out/share/fcitx5/pinyin/dictionaries
  '';

  meta = with lib; {
    homepage = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki";
    description = "Fcitx 5 Pinyin Dictionary from zh.wikipedia.org";
    license = licenses.unlicense;
  };
}
