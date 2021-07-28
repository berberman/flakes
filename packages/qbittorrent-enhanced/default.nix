# Copied from https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/networking/p2p/qbittorrent/default.nix#L50
# with modifications
{ stdenv, lib, fetchFromGitHub, makeWrapper, pkg-config, boost
, libtorrent-rasterbar, qt5, python3, dbus, mySource }:

with lib;
stdenv.mkDerivation rec {
  inherit (mySource) pname src;
  version = removePrefix "release-" mySource.version;

  enableParallelBuilding = true;

  nativeBuildInputs = [ makeWrapper pkg-config qt5.wrapQtAppsHook ];

  buildInputs = [ boost libtorrent-rasterbar python3 dbus ]
    ++ (with qt5; [ qtbase qtsvg qttools ]);

  # Otherwise qm_gen.pri assumes lrelease-qt5, which does not exist.
  QMAKE_LRELEASE = "lrelease";

  CXXFLAGS = "-std=c++17";

  configureFlags =
    [ "--with-boost-libdir=${boost.out}/lib" "--with-boost=${boost.dev}" ];

  postInstall = "wrapProgram $out/bin/qbittorrent --prefix PATH : ${
      makeBinPath [ python3 ]
    }";

  passthru = {
    runnable = true;
    program = "qbittorrent";
  };

  meta = {
    description =
      "A bittorrent client powered by C++, Qt5 and the good libtorrent library (Enhanced Edition)";
    homepage = "https://github.com/c0re100/qBittorrent-Enhanced-Edition";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
