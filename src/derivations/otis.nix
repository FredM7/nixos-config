{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
    name = "otis";
    src = fetchFromGitHub {
        owner = "EliverLara";
        repo = "otis";
        rev = "be7895c0358da0802b68f5c182be8f3ca1c336d3";
        hash = "sha256-pzX3c4qiK2VkSncWEdL8Os+vNg04LxkdSYHG8iuvltg=";
    };
    
    # cp -r $src $out
    installPhase = ''
        mkdir -p $out/share/themes/otis
        cp -r $src/* $out/share/themes/otis
    '';
}