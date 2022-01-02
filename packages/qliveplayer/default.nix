{ stdenv, lib, ffmpeg, qt5, cmake, extra-cmake-modules, mySource, mpv, curl
, streamlink, makeWrapper, rustPlatform, perl }:

stdenv.mkDerivation rec {

  inherit (mySource) pname version src;

  nativeBuildInputs =
    [ cmake extra-cmake-modules qt5.wrapQtAppsHook makeWrapper perl ]
    ++ (with rustPlatform; [ cargoSetupHook rust.cargo rust.rustc ]);

  buildInputs = with qt5; [
    qtbase
    qtquickcontrols
    qtquickcontrols2
    qtgraphicaleffects
    qtsvg
    qtdeclarative
    mpv
  ];

  postInstall = ''
    EXE=${lib.makeBinPath [ ffmpeg mpv curl streamlink ]}

    wrapProgram $out/bin/qliveplayer \
      --prefix PATH : "$out/bin:$EXE" \

  '';

  cargoRoot = "src/QLivePlayer-Lib";
  cargoDeps = rustPlatform.importCargoLock mySource.cargoLock;

  passthru.runnable = true;

  meta = with lib; {
    description = "A cute and useful Live Stream Player with danmaku support.";
    homepage = "https://github.com/THMonster/QLivePlayer";
    license = licenses.gpl2Only;
  };
}
