{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config
, glib, systemd, udev, libevdev, gitMinimal, check, valgrind, swig, python3
, json-glib, libunistring }:

stdenv.mkDerivation rec {
  name = "libratbag";
  # version = "0.17";

  src = fetchFromGitHub {
    owner  = "libratbag";
    repo   = "libratbag";
    rev    = "22ddb717aa1095e23f0e5a128b607c9805bc6110"; # "v${version}";
    sha256 = "sha256-TQ8DVj4yqq3IA0oGnLDz+QNTyNRmGqspEjkPeBmXNew=";
  };

  nativeBuildInputs = [
    meson ninja pkg-config gitMinimal swig check valgrind
  ];

  buildInputs = [
    glib systemd udev libevdev json-glib libunistring
    (python3.withPackages (ps: with ps; [ evdev pygobject3 ]))
  ];

  mesonFlags = [
    "-Dsystemd-unit-dir=./lib/systemd/system/"
  ];

  buildPhase = ''
    meson $out
    ninja -C $out
  '';
}