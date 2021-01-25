{ stdenv, lib, pythonPackages, qasync, mpv, mySource }:

let inherit (pythonPackages) buildPythonApplication;

in buildPythonApplication rec {

  pname = "feeluown";

  inherit (mySource) version src;

  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    dbus-python
    setuptools
    pyqt5
    pyopengl
    janus
    requests
    tomlkit
  ]) ++ [ mpv qasync ];

  postUnpack = ''
    substituteInPlace ./${pname}-${version}/mpv.py \
      --replace "_dll = ctypes.util.find_library(_default_mpv_dylib)" \
                '_dll = "${mpv}/lib/libmpv${stdenv.targetPlatform.extensions.sharedLibrary}"'
    substituteInPlace ./${pname}-${version}/feeluown/linux/__init__.py \
      --replace dbus.mainloop.pyqt5 dbus.mainloop.glib \
      --replace DBusQtMainLoop DBusGMainLoop
  '';

  dontWrapPythonPrograms = true;

}
