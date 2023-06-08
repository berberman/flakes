{ stdenv, lib, makeDesktopItem, copyDesktopItems, feeluown-core
, feeluown-netease, feeluown-kuwo, feeluown-qqmusic, feeluown-ytmusic
, feeluown-bilibili, pythonPackages, qt5, }:

let
  inherit (pythonPackages) python wrapPython;
  desktopItems = [
    (makeDesktopItem rec {
      name = "FeelUOwn";
      desktopName = name;
      exec = "feeluown --log-to-file";
      categories = [ "AudioVideo" "Audio" "Player" "Qt" ];
      terminal = false;
      icon =
        "${feeluown-core}/lib/${python.executable}/site-packages/feeluown/gui/assets/icons/feeluown.png";
      comment = "FeelUOwn Launcher";
      startupNotify = true;
      startupWMClass = "FeelUOwn";
    })
  ];
in stdenv.mkDerivation {

  pname = "feeluown";
  inherit (feeluown-core) version src;
  inherit desktopItems;

  nativeBuildInputs = [ wrapPython qt5.wrapQtAppsHook copyDesktopItems ];

  buildInputs = [
    feeluown-core
    feeluown-netease
    feeluown-kuwo
    feeluown-qqmusic
    feeluown-bilibili
    feeluown-ytmusic
  ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ${feeluown-core}/bin/* $out/bin
    rm $out/bin/feeluown-genicon
    runHook postInstall
  '';

  preFixup = ''
    wrapPythonProgramsIn "$out/bin" "$buildInputs"
    wrapQtApp $out/bin/feeluown
    wrapQtApp $out/bin/fuo
  '';

  passthru.runnable = true;

  meta = with lib; {
    homepage = "https://github.com/feeluown/FeelUOwn";
    description = "FeelUOwn Music Player";
    license = licenses.gpl3Only;
  };
}
