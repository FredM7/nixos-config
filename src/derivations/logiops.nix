{ pkgs, stdenv, fetchFromGitHub, pkg-config, cmake, git, 
  libevdev, libudev-zero, glib, libconfig, pcre, pcre2, 
  libuuid, libselinux, libsepol, udev
}:
stdenv.mkDerivation rec {
  name = "logiops";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner  = "PixlOne";
    repo   = "logiops";
    rev    = "v${version}";
    sha256 = "sha256-9nFTud5szQN8jpG0e/Bkp+I9ELldfo66SdfVCUTuekg="; # pkgs.lib.fakeSha256;
    fetchSubmodules = true;
  };

  PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ udev libevdev libconfig ];

  # buildInputs = [
  #   cmake libevdev glib pkg-config libconfig libudev-zero pcre pcre2 libuuid libselinux libsepol git
  # ];

  # buildPhase = ''
  #   mkdir -p $out
  #   cd $out
  #   cmake -DCMAKE_BUILD_TYPE=Release ..
  #   make
  # '';

  # installPhase = ''
  #   make install
  # '';
}