# broken

{ lib, pythonPackages, fetchFromGitHub }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "OpenCC";
  version = "1.1.1.post1";

  src = fetchFromGitHub {
    owner = "BYVoid";
    repo = "OpenCC";
    rev = "ver.${version}";
    sha256 = "1ygj2ygxsva72hs6cm0a6wdd2rp71k4nm0pd7cb20y2srdlzvdqk";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ setuptools ];

  meta = with lib; {
    homepage = "https://github.com/BYVoid/OpenCC";
    description = "Conversion between Traditional and Simplified Chinese";
    license = licenses.asl20;
  };
}
