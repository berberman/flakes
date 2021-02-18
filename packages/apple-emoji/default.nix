{ stdenv, lib, mySource }:

stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -D -m644 $src $out/share/fonts/truetype/AppleColorEmoji.ttf
  '';

  meta = with lib; {
    homepage = "https://github.com/samuelngs/apple-emoji-linux";
    description = "Apple Color Emoji for Linux";
    license = licenses.unlicense;
  };
}
