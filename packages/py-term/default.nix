{ lib, pythonPackages, mySource}:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://github.com/gravmatt/py-term";
    description =
      "Python module to style terminal output, moving and positioning the cursor.";
  };
}
