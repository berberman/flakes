{ lib, pythonPackages, feeluown-core }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "fuo_qqmusic";
  version = "0.3.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "HuWgH8aE0I/MQ+CWjhs4R3skt9Wgu+/N2EOXDphQcBo=";
  };

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
