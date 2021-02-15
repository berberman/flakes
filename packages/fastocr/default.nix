{ lib, pythonPackages, mySource, makeDesktopItem, qasync, python-baidu-aip
, sources }:

let
  inherit (pythonPackages) buildPythonApplication pyside2;

  new-pyside2 =
    pyside2.overrideAttrs (_: { inherit (sources.new-pyside2) version src; });

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

  propagatedBuildInputs = (with pythonPackages; [ dbus-python setuptools ])
    ++ [ new-pyside2 qasync python-baidu-aip ];

  postInstall = ''
    install -D ${desktop}/share/applications/FastOCR.desktop $out/share/applications/FastOCR.desktop
  '';

  meta = with lib; {
    homepage = "https://github.com/BruceZhang1993/FastOCR";
    description = "FastOCR is a desktop application for OCR API.";
    license = licenses.lgpl3Only;
  };
}
