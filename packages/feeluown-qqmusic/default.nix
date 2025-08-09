{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  format = "setuptools";
  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ setuptools marshmallow requests ])
    ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-qqmusic";
    description = "feeluown qqmusic plugin";
    license = licenses.gpl3Only;
  };
}
