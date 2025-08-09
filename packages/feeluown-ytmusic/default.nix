{ lib, pythonPackages, feeluown-core, mySource, feeluown-netease }:

let inherit (pythonPackages) buildPythonPackage;

in buildPythonPackage rec {
  inherit (mySource) pname version src;

  format = "setuptools";
  doCheck = false;

  propagatedBuildInputs =
    (with pythonPackages; [ setuptools ytmusicapi cachetools pydantic yt-dlp ])
    ++ [ feeluown-core ];

  meta = with lib; {
    homepage = "https://github.com/feeluown/feeluown-ytmusic";
    description = "YouTube Music plugin for FeelUOwn player";
    license = licenses.gpl3Only;
  };
}
