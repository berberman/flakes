final: prev: {
  groonga_with_msgpack =
    (prev.groonga.override { suggestSupport = true; }).overrideAttrs (old: {
      configureFlags = old.configureFlags ++ [ "--enable-message-pack" ];
    });
  pgroonga_2_4_5 = with final;
    stdenv.mkDerivation rec {
      pname = "pgroonga";
      version = "2.4.5";

      src = pkgs.fetchurl {
        url =
          "https://packages.groonga.org/source/pgroonga/pgroonga-${version}.tar.gz";
        hash = "sha256-CS33EgnXQGFM8SZheD2xpLH4qYvmJDtr306oy248BcI=";
      };

      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ postgresql msgpack groonga_with_msgpack ];

      makeFlags = [ "HAVE_MSGPACK=1" ];

      installPhase = ''
        install -D pgroonga.so -t $out/lib/
        install -D pgroonga.control -t $out/share/postgresql/extension
        install -D data/pgroonga-*.sql -t $out/share/postgresql/extension

        install -D pgroonga_database.so -t $out/lib/
        install -D pgroonga_database.control -t $out/share/postgresql/extension
        install -D data/pgroonga_database-*.sql -t $out/share/postgresql/extension
      '';
    };
}
