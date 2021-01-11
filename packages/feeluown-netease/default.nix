{ lib, pythonPackages, feeluown }:

let
  buildPythonPackage = pythonPackages.buildPythonApplication;
  fetchPypi = pythonPackages.fetchPypi;

in buildPythonPackage rec {
  pname = "fuo_netease";
  version = "0.4.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "AR94sP4e1dadm+ytj+GyXBnLDsGykrayHaQSx3GY3Ac=";
  };

  doCheck = false;

  propagatedBuildInputs = (with pythonPackages; [
    pycryptodome
    setuptools
    beautifulsoup4
    marshmallow
    requests
  ]) ++ [ feeluown ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-netease";
    description = "feeluown netease plugin";
  };
}
