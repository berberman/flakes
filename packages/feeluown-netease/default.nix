{ lib, pythonPackages, feeluown-core, mySource }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {

  pname = "fuo_netease";
  version = "0.4.4";

  # mySource is not used, because the latest version supports only the alpha core
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
  ]) ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-netease";
    description = "feeluown netease plugin";
    license = licenses.gpl3Only;
  };
}
