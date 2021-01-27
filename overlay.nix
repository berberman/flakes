sources: self: super: {

  picom-next = super.picom.overrideAttrs (old: {
    version = "8.3-next";
    src = super.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "d974367a0446f4f1939daaada7cb6bca84c893ef";
      sha256 = "mx60aWR+4hlwMHwEhYSNXZfHfGog5c2aHolMtgkpVVY=";
      fetchSubmodules = true;
    };
  });

}
