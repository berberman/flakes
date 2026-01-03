{ lib, nv-sources, rustPlatform }:
rustPlatform.buildRustPackage {

  pname = "luoxu-cutwords";

  inherit (nv-sources.luoxu) version;

  src = "${nv-sources.luoxu.src}/luoxu-cutwords";

  cargoLock = nv-sources.luoxu.cargoLock."luoxu-cutwords/Cargo.lock";
  passthru.runnable = true;

  meta = with lib; {
    homepage = "https://github.com/lilydjwg/luoxu";
    description = "Cut words for luoxu wordcloud plugin";
    license = licenses.gpl3Only;
  };
}
