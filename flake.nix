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
      broken = (import ./broken.nix).broken;
      sources = import ./_sources/generated.nix;
      names = with builtins;
        nixpkgs.lib.subtractLists broken (attrNames (readDir pkgDir));
      withContents = f: with builtins; listToAttrs (map (genPkg f) names);
    in {
      overlay = final: prev:
        let
          sources' =
            sources { inherit (final) fetchurl fetchgit fetchFromGitHub; };
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
    } // (let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlay nvfetcher.overlay ];
      };
    in rec {
      packages.x86_64-linux = withContents (name: pkgs.${name});
      apps.x86_64-linux = withContents (name:
        let drv = pkgs.${name};
        in if drv.passthru.runnable or false then {
          type = "app";
          program = "${drv}/bin/${drv.passthru.program or name}";
        } else
          builtins.throw "${name} is not a runnable application!");
      checks.x86_64-linux = packages.x86_64-linux;
      devShell.x86_64-linux = nvfetcher.packages.x86_64-linux.ghcWithNvfetcher;
    });

}
