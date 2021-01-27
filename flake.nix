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
      broken = (import ./broken.nix).broken;
      sources = import ./sources.nix;
      names = with builtins;
        nixpkgs.lib.subtractLists broken (attrNames (readDir pkgDir));
      withContents = f: with builtins; listToAttrs (map (genPkg f) names);
    in with flake-utils.lib;
    {
      overlay = final: prev:
        let sources' = sources { inherit (final) fetchurl fetchFromGitHub; };
        in withContents (name:
          let
            pkg = import (pkgDir + "/${name}");
            override = builtins.intersectAttrs (builtins.functionArgs pkg) ({
              pythonPackages = final.python3.pkgs;
              mySource = sources'.${name};
            });
          in final.callPackage pkg override) // {
            sources = sources';
          };
    } // eachSystem
    (nixpkgs.lib.subtractLists [ "x86_64-darwin" "i686-linux" ] defaultSystems)
    (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in {
        packages = withContents (name: pkgs.${name});
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              nvchecker
              nix-prefetch
              haskell-language-server
              (haskellPackages.ghcWithPackages
                (p: with p; [ aeson neat-interpolation async ]))
            ];
          };
      });

}
