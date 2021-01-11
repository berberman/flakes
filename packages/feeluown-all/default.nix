{ symlinkJoin, feeluown, feeluown-netease, pythonPackages }:

let wrapPython = pythonPackages.wrapPython;

in symlinkJoin {
  inherit (feeluown) name;
  paths = [ feeluown feeluown-netease ];
  buildInputs = [ wrapPython ];
}
