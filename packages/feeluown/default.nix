{ stdenv, lib, makeDesktopItem, feeluown-core, feeluown-netease, feeluown-kuwo
, feeluown-qqmusic, feeluown-local, feeluown-xiami, pythonPackages, qt5 }:

let
  inherit (pythonPackages) python wrapPython;
  desktop = makeDesktopItem rec {
    name = "FeelUOwn";
    desktopName = name;
    exec = "feeluown --log-to-file";
    categories = "AudioVideo;Audio;Player;Qt;";
    terminal = "false";
    icon =
      "${feeluown-core}/lib/${python.executable}/site-packages/feeluown/icons/feeluown.png";
    comment = "FeelUOwn Launcher";
    startupNotify = "true";
    extraEntries = ''
      StartupWMClass=${name}
          '';
  };
in stdenv.mkDerivation {

  pname = "feeluown";
  inherit (feeluown-core) version src;

  nativeBuildInputs = [ wrapPython qt5.wrapQtAppsHook ];

  buildInputs = [
    feeluown-core
    feeluown-netease
    feeluown-kuwo
    feeluown-qqmusic
    feeluown-local
    feeluown-xiami
  ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ${feeluown-core}/bin/* $out/bin
    rm $out/bin/feeluown-genicon
    install -D ${desktop}/share/applications/FeelUOwn.desktop $out/share/applications/FeelUOwn.desktop
    runHook postInstall
  '';

  preFixup = ''
    wrapPythonProgramsIn "$out/bin" "$buildInputs"
    wrapQtApp $out/bin/feeluown
  '';

  meta = with lib; {
    homepage = "https://github.com/feeluown/FeelUOwn";
    description = "FeelUOwn Music Player";
    license = licenses.gpl3Only;
  };
}
