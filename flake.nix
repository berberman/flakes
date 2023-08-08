{
  description = "A useless flake by berberman";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nvfetcher.url = "github:berberman/nvfetcher";
  inputs.nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, nvfetcher }:
    let
      genPkg = f: name: {
        inherit name;
        value = f name;
      };
      pkgDir = ./packages;
      broken = import ./broken.nix;
      generated = import ./_sources/generated.nix;
      overlays = import ./overlays.nix;
      names = with builtins;
        nixpkgs.lib.subtractLists broken (attrNames (readDir pkgDir));
      withContents = f: with builtins; listToAttrs (map (genPkg f) names);
    in {
      overlays.default = final: prev:
        prev.lib.composeManyExtensions [
          overlays
          (final: prev: {
            sources = generated {
              inherit (final) fetchurl fetchgit fetchFromGitHub dockerTools;
            };
          })
          (final: prev:
            withContents (name:
              let
                pkg = import (pkgDir + "/${name}");
                override =
                  builtins.intersectAttrs (builtins.functionArgs pkg) ({
                    pythonPackages = final.python3.pkgs;
                    mySource = prev.sources.${name} or null;
                  });
              in final.callPackage pkg override))
        ] final prev;
    } // (let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.default nvfetcher.overlays.default ];
        config.allowUnfree = true;
      };
    in rec {
      nixosModules.default = ./modules;
      legacyPackages.x86_64-linux = pkgs;
      packages.x86_64-linux = withContents (name: pkgs.${name});
      apps.x86_64-linux = withContents (name:
        let drv = pkgs.${name};
        in if drv.passthru.runnable or false then {
          type = "app";
          program = "${drv}/bin/${drv.passthru.program or name}";
        } else
          builtins.throw "${name} is not a runnable application!");
      checks.x86_64-linux = packages.x86_64-linux;
      devShells.x86_64-linux.default =
        nvfetcher.packages.x86_64-linux.ghcWithNvfetcher;
    });

}
