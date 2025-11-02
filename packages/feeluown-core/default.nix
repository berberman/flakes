{ stdenv, lib, pythonPackages, mpv, mySource }:

let inherit (pythonPackages) buildPythonApplication;

in buildPythonApplication rec {

  pname = "feeluown";

  inherit (mySource) version src;

  format = "setuptools";
  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    dbus-python
    setuptools
    pyqt5
    pyopengl
    janus
    requests
    tomlkit
    pydantic
    packaging
    mutagen
    qasync
    openai
  ]) ++ [ mpv ];

  postUnpack = ''
    substituteInPlace ./${pname}-${version}/feeluown/mpv.py \
      --replace "_dll = ctypes.util.find_library(_default_mpv_dylib)" \
                '_dll = "${mpv}/lib/libmpv${stdenv.targetPlatform.extensions.sharedLibrary}"'
    substituteInPlace ./${pname}-${version}/feeluown/nowplaying/linux/__init__.py \
      --replace dbus.mainloop.pyqt5 dbus.mainloop.glib \
      --replace DBusQtMainLoop DBusGMainLoop
  '';

  dontWrapPythonPrograms = true;

  meta = with lib; {
    homepage = "https://github.com/feeluown/FeelUOwn";
    description = "FeelUOwn Music Player";
    license = licenses.gpl3Only;
  };
}
