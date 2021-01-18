{ lib, pythonPackages }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "pypinyin";
  version = "0.40.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "P0jY/U56XIh74zO7PqwHtwchGM858RgXTNvReX2exbM=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ setuptools ];

  meta = with lib; {
    homepage = "https://github.com/mozillazg/python-pinyin";
    description = "Chinese characters transliteration module and tool";
    license = licenses.mit;
  };
}
