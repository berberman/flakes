{ lib, pythonPackages, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  propagatedBuildInputs = with pythonPackages; [ setuptools requests ];

  meta = with lib; {
    homepage = "https://github.com/Baidu-AIP/python-sdk";
    description = "百度AI开放平台 Python SDK";
    license = licenses.asl20;
  };
}
