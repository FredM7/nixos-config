{ stdenv, fetchFromGitHub, ruby, inkscape, xorg, makeFontsConf }:
stdenv.mkDerivation {
    name = "otis";
    src = fetchFromGitHub {
        owner = "EliverLara";
        repo = "otis";
        rev = "be7895c0358da0802b68f5c182be8f3ca1c336d3";
        hash = "";
    };
    nativeBuildInputs = [ ruby inkscape xorg.xcursorgen ];
    env.HOME = "/build";
    env.FONTCONFIG_FILE = makeFontsConf { fontDirectories = []; };
    preBuild = "ruby generator/convert.rb";
    makeFlags = [ "PREFIX=${placeholder "out"}" ];
}