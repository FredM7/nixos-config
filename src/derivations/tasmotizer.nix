{ lib, stdenv, fetchFromGitHub, python3Full, esptool, virtualenv, python312Packages, libsForQt5 }:

stdenv.mkDerivation rec {
  pname = "tasmotizer";
  version = "1.2";  # Use the appropriate version

  src = fetchFromGitHub {
    owner = "tasmota";
    repo = "tasmotizer";
    rev = "cc9d34e64cc6e9811485fcabdc0e63a5142182f0";  # Use the latest release or commit hash
    sha256 = "sha256-LTlsUEuWw1UTNeMVa5t4PRqzSR3lP1XkIM+3BOPWl2A=";
  };

  nativeBuildInputs = [ ];

  p3wp = (python3Full.withPackages (ps: with ps; [
    pyqt5
    requests
    pyserial
  ]));

  buildInputs = [
    p3wp
    virtualenv
    esptool
    # libsForQt5.qt5.qtserialport
  ];

  dontWrapQtApps = true;
  doCheck = false;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r ${src}/* $out/bin/
    chmod +x $out/bin/tasmotizer.py

    # Create a wrapper script
    cat > $out/bin/tasmotizer <<EOF
#!/bin/sh
exec ${p3wp}/bin/python $out/bin/tasmotizer.py "\$@"
EOF
    chmod +x $out/bin/tasmotizer

    runHook postInstall
  '';

  # meta = with stdenv.lib; {
  #   description = "Tasmotizer is a tool to flash ESP8266 devices with Tasmota firmware";
  #   homepage = "https://github.com/tasmota/tasmotizer";
  #   license = licenses.mit;
  #   maintainers = [ FredM7 ];
  #   platforms = platforms.linux;
  # };
}
