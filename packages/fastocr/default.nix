{ lib, pythonPackages, mySource, makeDesktopItem, qasync, qt5 }:

let
  inherit (pythonPackages) buildPythonApplication;

  desktop = makeDesktopItem rec {
    name = "FastOCR";
    desktopName = name;
    exec = "fastocr";
    categories = "Graphics;";
    terminal = "false";
    comment = "A OCR tool for Linux desktop";
    startupNotify = "false";
    genericName = "OCR Tool";
    extraEntries = ''
      GenericName[zh_CN]=OCR 识别工具
      X-DBUS-StartupType=Unique
      X-KDE-DBUS-Restricted-Interfaces=org.kde.kwin.Screenshot
    '';
  };

in buildPythonApplication rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ dbus-python setuptools pyqt5 click aiohttp ])
    ++ [ qasync ];

  nativeBuildInputs = [ qt5.wrapQtAppsHook ];

  postInstall = ''
    install -D ${desktop}/share/applications/FastOCR.desktop $out/share/applications/FastOCR.desktop
  '';

  postFixup = ''
    wrapQtApp $out/bin/fastocr
  '';

  meta = with lib; {
    homepage = "https://github.com/BruceZhang1993/FastOCR";
    description = "FastOCR is a desktop application for OCR API.";
    license = licenses.lgpl3Only;
  };
}
