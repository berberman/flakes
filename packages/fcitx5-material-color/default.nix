{ stdenv, lib, mySource }:

stdenv.mkDerivation rec {
  inherit (mySource) pname version src;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -Dm644 arrow.png radio.png -t $out/share/${pname}/
    for _variant in black blue brown deepPurple indigo orange pink red sakuraPink teal; do
      _variant_name=Material-Color-''${_variant^}
      mkdir -p $out/share/fcitx5/themes/$_variant_name/
      ln -s $out/share/${pname}/arrow.png $out/share/fcitx5/themes/$_variant_name/arrow.png
      ln -s $out/share/${pname}/radio.png $out/share/fcitx5/themes/$_variant_name/radio.png
      install -Dm644 theme-$_variant.conf $out/share/fcitx5/themes/$_variant_name/theme.conf
      sed -i "s/^Name=.*/Name=$_variant_name/" $out/share/fcitx5/themes/$_variant_name/theme.conf
    done
  '';

  meta = with lib; {
    homepage = "https://github.com/hosxy/Fcitx5-Material-Color";
    description = "Material color theme for fcitx5";
    license = licenses.asl20;
  };
}
