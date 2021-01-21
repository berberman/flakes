{ stdenv, pythonPackages, lib, ffmpeg, qt5, cmake, extra-cmake-modules
, fetchFromGitHub, mpv, curl, streamlink, makeWrapper }:

stdenv.mkDerivation rec {

  pname = "qliveplayer";
  version = "3.21.0";

  src = fetchFromGitHub {
    owner = "IsoaSFlus";
    repo = "QLivePlayer";
    rev = version;
    sha256 = "/FngoMpSJaALgrCaqq5F3dOtcjVMBzmMTyEN39u7ulY=";
    fetchSubmodules = true;
  };

  nativeBuildInputs =
    [ cmake extra-cmake-modules qt5.wrapQtAppsHook makeWrapper ];

  buildInputs = with qt5; [
    qtbase
    qtquickcontrols
    qtquickcontrols2
    qtgraphicaleffects
    mpv
  ];

  propagatedBuildInputs = with pythonPackages; [ python aiohttp protobuf ];

  postInstall = ''
    EXE=${lib.makeBinPath [ ffmpeg mpv curl streamlink pythonPackages.python ]}

    wrapProgram $out/bin/qliveplayer \
      --prefix PATH : "$out/bin:$EXE" \
      --prefix PYTHONPATH : $PYTHONPATH
    wrapProgram $out/bin/qlphelper \
      --prefix PATH : "$out/bin:$EXE" \
      --prefix PYTHONPATH : $PYTHONPATH

  '';

  meta = with lib; {
    description = "A cute and useful Live Stream Player with danmaku support.";
    homepage = "https://github.com/IsoaSFlus/QLivePlayer";
    license = licenses.gpl2Only;
  };
}
