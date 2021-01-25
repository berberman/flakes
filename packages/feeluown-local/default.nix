{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ setuptools mutagen marshmallow fuzzywuzzy ])
    ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-local";
    description = "feeluown local plugin";
    license = licenses.gpl3Only;
  };
}
