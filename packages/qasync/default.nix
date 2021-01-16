{ lib, pythonPackages }:

let inherit (pythonPackages) buildPythonPackage fetchPypi;

in buildPythonPackage rec {
  pname = "qasync";
  version = "0.13.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "B6GUqfF3Bu7JCFlrOkC0adLL+BwbnTOVNXpMkQRLovI=";
  };

  # check needs X server
  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ pyqt5 ];

  meta = with lib; {
    homepage = "https://github.com/CabbageDevelopment/qasync";
    description = "Python library for using asyncio in Qt-based applications";
    license = licenses.bsd3;
  };
}
