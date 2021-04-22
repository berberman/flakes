{
  description = "A useless flake by berberman";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nvfetcher.url = "github:berberman/nvfetcher";
  inputs.nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flake-utils, nvfetcher }:
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
        let sources' = sources { inherit (final) fetchurl fetchgit; };
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
    # TODO blocked by nvfetcher
    ([ "x86_64-linux" ]) (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay nvfetcher.overlay ];
        };
      in rec {
        packages = withContents (name: pkgs.${name});
        checks = packages;
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              nvchecker
              nix-prefetch-git
              haskell-language-server
              (haskellPackages.ghcWithPackages (p: [ p.nvfetcher ]))
            ];
          };
      });

}
