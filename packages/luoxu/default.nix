{ fetchFromGitHub, python3, rustPlatform, rustc, cargo, opencc, pkg-config
, mySource }:

with python3.pkgs;

buildPythonApplication rec {
  inherit (mySource) pname src version;

  nativeBuildInputs =
    [ rustPlatform.cargoSetupHook setuptools-rust cargo rustc pkg-config ];

  buildInputs = [ opencc ];

  propagatedBuildInputs = [ asyncpg telethon aiohttp tomli setuptools pysocks ];

  cargoDeps =
    rustPlatform.importCargoLock mySource.cargoLock."querytrans/Cargo.lock";

  preBuild = ''
    substituteInPlace luoxu/__main__.py --replace "if __name__ == '__main__':" "def entry_point():"
    substituteInPlace luoxu/ls_dialogs.py --replace "if __name__ == '__main__':" "def entry_point():"
    cat > setup.py << EOF
    from setuptools import setup, find_packages
    from setuptools_rust import Binding, RustExtension
    with open('requirements.txt') as f:
        install_requires = f.read().splitlines()
    setup(
      name='luoxu',
      version='0.0.0',
      install_requires=install_requires,
      packages=find_packages(),
      entry_points={
        'console_scripts': ['luoxu=luoxu.__main__:entry_point', 'luoxu-ls_dialogs=luoxu.ls_dialogs:entry_point']
      },
      rust_extensions=[RustExtension('querytrans', 'querytrans/Cargo.toml')],
      zip_safe=False,
    )
    EOF
  '';

  cargoRoot = "querytrans";
  # to use unstable features
  RUSTC_BOOTSTRAP = 1;

  postInstall = ''
    install -Dm644 nobody.jpg ghost.jpg dbsetup.sql -t $out/share/${pname}/
  '';

  passthru.runnable = true;

  meta = with lib; {
    homepage = "https://github.com/lilydjwg/luoxu";
    description =
      "A Telegram userbot to index Chinese and Japanese group contents.";
    license = licenses.gpl3Only;
  };
}
