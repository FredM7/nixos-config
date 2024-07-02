
{ stdenv, fetchurl, unzip, sqlite, makeWrapper, dotnet-sdk, ffmpeg, makeDesktopItem }:

stdenv.mkDerivation rec {
  name = "emby-theater";
  version = "3.0.19";

  # We are fetching a binary here, however, a source build is possible.
  # See -> https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=emby-server-git#n43
  # Though in my attempt it failed with this error repeatedly
  # The type 'Attribute' is defined in an assembly that is not referenced. You must add a reference to assembly 'netstandard, Version=2.0.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51'.
  # This may also need msbuild (instead of xbuild) which isn't in nixpkgs
  # See -> https://github.com/NixOS/nixpkgs/issues/29817
  src = fetchurl {
    url = "https://github.com/MediaBrowser/emby-theater-electron/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-cAQCoXat9b4eSXuPdQDyujtcUxH5VssjwlO4BqAyu6k=";
  };

  dontConfigure = true;

  desktopItems = [
      (makeDesktopItem {
      name = "emby-theater";
      exec = "emby-theater";
      icon = "emby-theater";
      comment = "Emby Theater Electron";
      desktopName = "Emby Media Theater";
      genericName = "Emby Media Theater";
      categories = [ "Video" ];
    })
  ];

  buildInputs = [
    unzip
    makeWrapper
  ];

  propagatedBuildInputs = [
    dotnet-sdk
    sqlite
  ];

  preferLocalBuild = true;

  buildPhase = ''
    rm -rf {electron,runtimes}
  '';

  installPhase = ''
    runHook preInstall

    # mkdir -p $out/share/${name}
    # cp -r $src/* $out
    echo $out
    echo $src
    mkdir -p $out/bin/${name}
    cp -rv $src $out/bin/${name}

    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/${name} \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--enable-features=UseOzonePlatform --ozone-platform=wayland}}"

    runHook postInstall
  '';

  # meta =  with stdenv.lib; {
  #   description = "MediaBrowser - Bring together your videos, music, photos, and live television";
  #   homepage = https://emby.media/;
  #   license = licenses.gpl2;
  #   maintainers = with maintainers; [ fadenb ];
  #   platforms = platforms.all;
  # };
}