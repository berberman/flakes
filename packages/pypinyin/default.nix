{ lib, pythonPackages, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ setuptools ];

  meta = with lib; {
    homepage = "https://github.com/mozillazg/python-pinyin";
    description = "Chinese characters transliteration module and tool";
    license = licenses.mit;
  };
}
