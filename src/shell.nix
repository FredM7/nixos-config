{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
		# NODE
        nodejs
		# RUST
		cargo
		rustc
		gcc
		rust-analyzer
		rustfmt
		# PYTHON
		python3
    ];

    shellHook = ''
        echo "Welcome! This is Fred's Nix Develpment shell."
    '';

    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}