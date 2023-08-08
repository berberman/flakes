{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    pycryptodome
    setuptools
    beautifulsoup4
    cachetools
  ]) ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-bilibili";
    description = "Yet another bilibili plugin for FeelUOwn player";
    license = licenses.gpl3Only;
  };
}
