{ lib, stdenv, pythonPackages, mySource, unrar, qpdf, py-term }:

let inherit (pythonPackages) buildPythonPackage wrapPython;

in stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  nativeBuildInputs = [ wrapPython ];

  buildInputs = [ unrar qpdf ];

  pythonPath = with pythonPackages; [
    rarfile
    pyfiglet
    py-term
    termcolor
  ];

  dontBuild = true;

  dontConfigure = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    buildPythonPath "$out $pythonPath"
    cp Zydra.py $out/bin/zydra
    chmod +x $out/bin/zydra
    runHook postInstall
  '';

  preFixup = ''
    wrapPythonPrograms "$out/bin" "$pythonPath $buildInputs"
  '';

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://github.com/hamedA2/Zydra";
    description =
      "Zydra is a file password recovery tool and Linux shadow file cracker.";
  };
}
