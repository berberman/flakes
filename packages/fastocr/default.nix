{ lib, pythonPackages, mySource, makeDesktopItem, copyDesktopItems, qasync, qt5 }:

let
  inherit (pythonPackages) buildPythonApplication;

  desktopItems = [
    (makeDesktopItem {
      name = "FastOCR";
      desktopName = "FastOCR";
      exec = "fastocr";
      categories = [ "Graphics" ];
      terminal = false;
      comment = "A OCR tool for Linux desktop";
      startupNotify = false;
      genericName = "OCR Tool";
      extraConfig = {
        "GenericName[zh_CN]" = "OCR 识别工具";
        "X-DBUS-StartupType" = "Unique";
        "X-KDE-DBUS-Restricted-Interfaces" = "org.kde.kwin.Screenshot";
      };
    })
  ];

in
buildPythonApplication rec {
  inherit (mySource) pname version src;
  inherit desktopItems;

  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ dbus-python setuptools pyqt5 click aiohttp dbus-next ])
    ++ [ qasync ];

  nativeBuildInputs = [ qt5.wrapQtAppsHook copyDesktopItems ];

  postFixup = ''
    qtWrapperArgs+=(--prefix QML2_IMPORT_PATH : "${qt5.qtquickcontrols2.bin}/lib/qt-${qt5.qtbase.version}/qml")
    # https://github.com/NixOS/nixpkgs/issues/28336
    wrapQtApp $out/bin/fastocr
  '';

  passthru.runnable = true;

  meta = with lib; {
    homepage = "https://github.com/BruceZhang1993/FastOCR";
    description = "FastOCR is a desktop application for OCR API.";
    license = licenses.lgpl3Only;
  };
}
