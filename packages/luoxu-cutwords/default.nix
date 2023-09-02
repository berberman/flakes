{ lib, sources, rustPlatform }:
rustPlatform.buildRustPackage {

  pname = "luoxu-cutwords";

  inherit (sources.luoxu) version;

  src = "${sources.luoxu.src}/luoxu-cutwords";

  cargoLock = sources.luoxu.cargoLock."luoxu-cutwords/Cargo.lock";

  passthru.runnable = true;

  meta = with lib; {
    homepage = "https://github.com/lilydjwg/luoxu";
    description = "Cut words for luoxu wordcloud plugin";
    license = licenses.gpl3Only;
  };
}
