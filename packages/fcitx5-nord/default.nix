{ stdenv, lib, mySource }:

stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -dm755 $out/share/fcitx5/themes/
    cp -r Nord-Dark Nord-Light $out/share/fcitx5/themes/
  '';

  meta = with lib; {
    homepage = "https://github.com/tonyfettes/fcitx5-nord";
    description = "Fcitx5 theme based on Nord color.";
    license = licenses.mit;
  };
}
