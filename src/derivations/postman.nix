{ lib
, stdenv
, fetchurl
, makeDesktopItem
, wrapGAppsHook
, atk
, at-spi2-atk
, at-spi2-core
, alsa-lib
, cairo
, cups
, dbus
, expat
, gdk-pixbuf
, glib
, gtk3
, freetype
, fontconfig
, nss
, nspr
, pango
, udev
, libsecret
, libuuid
, libX11
, libxcb
, libXi
, libXcursor
, libXdamage
, libXrandr
, libXcomposite
, libXext
, libXfixes
, libXrender
, libXtst
, libXScrnSaver
, libxkbcommon
, libdrm
, mesa
# It's unknown which version of openssl that postman expects but it seems that
# OpenSSL 3+ seems to work fine (cf.
# https://github.com/NixOS/nixpkgs/issues/254325). If postman breaks apparently
# around OpenSSL stuff then try changing this dependency version.
, openssl
, xorg
, copyDesktopItems
, makeWrapper
}:
let
    postman = "postman";
    version = "10.23.5";
in
stdenv.mkDerivation rec {
  name = "postman";

  src = fetchurl {
    url = "https://dl.pstmn.io/download/latest/linux_64";
    name = "${postman}-${version}.tar.gz";
    hash = "sha256-OiuWeSpmrnE5wN4AmUhEAL+bibv8fS3GW2gA6uuS1rs=";
  };

  dontConfigure = true;

  desktopItems = [
      (makeDesktopItem {
      name = "postman";
      exec = "postman";
      icon = "postman";
      comment = "API Development Environment";
      desktopName = "Postman";
      genericName = "Postman";
      categories = [ "Development" ];
    })
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    atk
    at-spi2-atk
    at-spi2-core
    alsa-lib
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    freetype
    fontconfig
    mesa
    nss
    nspr
    pango
    udev
    libdrm
    libsecret
    libuuid
    libX11
    libxcb
    libXi
    libXcursor
    libXdamage
    libXrandr
    libXcomposite
    libXext
    libXfixes
    libXrender
    libXtst
    libXScrnSaver
    libxkbcommon
    xorg.libxshmfence
  ];

  nativeBuildInputs = [ wrapGAppsHook copyDesktopItems ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/postman
    cp -R app/* $out/share/postman
    rm $out/share/postman/Postman

    mkdir -p $out/bin
    ln -s $out/share/postman/postman $out/bin/postman

    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/postman \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--enable-features=UseOzonePlatform --ozone-platform=wayland}}"

    mkdir -p $out/share/icons/hicolor/128x128/apps
    ln -s $out/share/postman/resources/app/assets/icon.png $out/share/icons/postman.png
    ln -s $out/share/postman/resources/app/assets/icon.png $out/share/icons/hicolor/128x128/apps/postman.png
    runHook postInstall
  '';

  postFixup = ''
    pushd $out/share/postman
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" postman
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" chrome_crashpad_handler
    for file in $(find . -type f \( -name \*.node -o -name postman -o -name \*.so\* \) ); do
      ORIGIN=$(patchelf --print-rpath $file); \
      patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:$ORIGIN" $file
    done
    popd
    wrapProgram $out/bin/postman --set PATH ${lib.makeBinPath [ openssl ]}
  '';
}