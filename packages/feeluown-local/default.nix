{ lib, pythonPackages, feeluown-core }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "fuo_local";
  version = "0.2.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "p5mkKOXDz4aW6N2hJNfnrH3OGxUlsRAN9Ax0jksT1EU=";
  };

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
