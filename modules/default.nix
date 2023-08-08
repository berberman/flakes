{ lib, ... }: {
  imports = let dir = ./.;
  in with lib;
  map (x: dir + ("/" + x))
  (filter (x: x != "default.nix") (attrNames (readDir dir)));
}
