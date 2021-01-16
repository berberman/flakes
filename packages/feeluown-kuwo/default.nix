{ lib, pythonPackages, feeluown-core }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "fuo_kuwo";
  version = "0.1.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "M/RDVmok9WMK7EXZ1+icRwBr5cD+hFt5rvRjdf9RmA0=";
  };

  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ setuptools marshmallow requests ])
    ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-kuwo";
    description = "Kuwo music provider for FeelUOwn music player";
    license = licenses.gpl3Only;
  };
}
