{ lib, pythonPackages, mySource }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  # check needs X server
  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ pyqt5 ];

  meta = with lib; {
    homepage = "https://github.com/CabbageDevelopment/qasync";
    description = "Python library for using asyncio in Qt-based applications";
    license = licenses.bsd3;
  };
}
