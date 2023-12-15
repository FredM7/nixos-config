{ stdenv, fetchFromGitHub,fetchurl, ruby, inkscape, xorg, makeFontsConf }:
stdenv.mkDerivation {
    name = "docker-desktop";
    src = fetchurl {
        url = "https://download.docker.com/linux/static/stable/x86_64/docker-17.03.0-ce.tgz";
        hash = "sha256-qsCFJNuC0/3I/AkvSV4RdPXh3XdLlabQgVRJl9NLSFU=";
    };

    dontUnpack = true;

    isntallPhase = ''
        mkdir -p $out/bin
        cp docker/* $out/bin
        chmod +x $out/bin/docker
    '';
}