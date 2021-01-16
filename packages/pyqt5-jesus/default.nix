{ symlinkJoin, pythonPackages, writeTextFile }:
let inherit (pythonPackages) python pyqt5;
in symlinkJoin {
  name = "pyqt5-jesus";
  paths = [ pyqt5 ];
  # this doesn't seem to work :(
  # can't run mpris2 server: No module named 'dbus.mainloop.pyqt5' is still around
  postBuild = ''
    touch $out/lib/${python.executable}/site-packages/dbus/__init__.py
    touch $out/lib/${python.executable}/site-packages/dbus/mainloop/__init__.py
  '';
}
