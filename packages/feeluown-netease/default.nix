{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    pycryptodome
    setuptools
    beautifulsoup4
    marshmallow
    requests
    mutagen
  ]) ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-netease";
    description = "feeluown netease plugin";
    license = licenses.gpl3Only;
  };
}
