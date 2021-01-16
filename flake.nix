{
  description = "A useless flake by berberman";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    let
      genPkg = f: name: {
        inherit name;
        value = f name;
      };
      pkgDir = ./packages;
      names = with builtins; attrNames (readDir pkgDir);
      withContents = f: with builtins; listToAttrs (map (genPkg f) names);
    in {
      overlay = final: prev:
        withContents (name:
          final.callPackage (pkgDir + "/${name}") {
            pythonPackages = final.python38.pkgs;
          });
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in { packages = withContents (name: pkgs.${name}); });

}
