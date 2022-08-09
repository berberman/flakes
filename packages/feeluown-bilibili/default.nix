{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    aiohttp
    pycryptodome
    setuptools
    beautifulsoup4
    cachetools
  ]) ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/BruceZhang1993/feeluown-bilibili";
    description = "Bilibili provider for FeelUOwn";
    license = licenses.gpl3Only;
  };
}
