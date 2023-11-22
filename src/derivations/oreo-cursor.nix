{ stdenv, fetchFromGitHub, ruby, inkscape, xorg, makeFontsConf }:
stdenv.mkDerivation {
    name = "oreo-cursor";
    src = fetchFromGitHub {
        owner = "varlesh";
        repo = "oreo-cursors";
        rev = "6b6d9410beb7c518486e8f4dfd1cb346c7797106";
        hash = "sha256-wwtGlyLlC1encO6A/vuVMS0HNSMv1Nsj+LRHZCR3Otc=";
    };
    nativeBuildInputs = [ ruby inkscape xorg.xcursorgen ];
    env.HOME = "/build";
    env.FONTCONFIG_FILE = makeFontsConf { fontDirectories = []; };
    preBuild = "ruby generator/convert.rb";
    makeFlags = [ "PREFIX=${placeholder "out"}" ];
}

# { pkgs }: pkgs.stdenv.mkDerivation rec {
#     name = "oreo-cursor";
#     # src = pkgs.fetchFromGitHub {
#     #     owner = "varlesh";
#     #     repo = "oreo-cursors";
#     #     rev = "master";
#     #     sha256 = "sha256-wwtGlyLlC1encO6A/vuVMS0HNSMv1Nsj+LRHZCR3Otc="; # pkgs.lib.fakeSha256;
#     # };

#     # src = ../themes/cursors/oreo-spark-dark-cursors.tar.gz;
#     # src = ../themes/cursors/oreo_spark_dark_cursors.zip;

#     # dontUnpack = true;

#     # src = pkgs.fetchurl {
#     #     url = "https://github.com/FredM7/nixos-config/blob/9706c1c2c3a280f369ee238d87322db60dcac0e1/src/themes/cursors/oreo-spark-dark-cursors.tar.gz";
#     #     hash = "sha256-19eZlpYqWD0t3QAtje9Du81sJcLJbudrrihV2Itxz0E="; # pkgs.lib.fakeSha256;
#     # };

#     # installPhase = ''
#     #     mkdir -p $out/share/icons
#     #     cp -r $src $out/share/icons/oreo-cursors
#     # '';

#     # installPhase = ''
#     #     mkdir -p $out
#     #     ${pkgs.unzip}/bin/unzip $src -d $out/share/icons/${name}
#     # '';

#     # installPhase = ''
#     #     mkdir -p $out/share/icons
#     #     ${pkgs.gnutar}/bin/tar -xvzf $src -C $out/share/icons/${name}
#     # '';

#     # installPhase = ''
#     #     mkdir -p $out
#     #     cp -R ./* $out/
#     # '';

#     # installPhase = ''
#     #     mkdir -p $out
#     #     ${pkgs.gnutar}/bin/tar -xvzf $src -C $out/
#     # '';

#     # installPhase = ''
#     #     mkdir -p $out
#     #     ${pkgs.unzip}/bin/unzip $src -d $out/
#     # '';
# }