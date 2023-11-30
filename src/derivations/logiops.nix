{ stdenv, fetchFromGitHub, pkg-config, cmake, libevdev, libudev, glib, libconfig }:

stdenv.mkDerivation rec {
  pname = "logiops";
#   version = "0.17.1";

  src = fetchFromGitHub {
    owner  = "PixlOne";
    repo   = "logiops";
    rev    = "94f6dbab5390c1c7375836dd9314c0c2488e48a3";
    sha256 = "sha256-TQ8DV....";
  };

  buildInputs = [
    cmake libevdev libudev glib libconfig
  ];

  # cmake -DCMAKE_INSTALL_PREFIX=$out ..
  buildPhase = ''
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=$out ..
    make
  '';

  installPhase = ''
    make install
  '';
}