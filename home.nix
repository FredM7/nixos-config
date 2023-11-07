{ pkgs, nixpkgs, anyrun, solaar, system, 
# my-old-revision,
#myPkg, 
... }: let
	# system = "x86_64-linux";
	#
 #  pkgs = import (builtins.fetchGit {
 #    # Descriptive name to make the store path easier to identify
 #    name = "my-old-revision";
 #    url = "https://github.com/NixOS/nixpkgs/";
 #    ref = "refs/heads/nixpkgs-unstable";
 #    rev = "976fa3369d722e76f37c77493d99829540d43845";
 #  }) { 
 #    # inherit system;
	# };
	#
 #  myPkg = pkgs.vscodium;
in {
	home.username = "fred";
	home.homeDirectory = "/home/fred";

	programs.home-manager.enable = true;

	imports = [
		./modules/anyrun.nix
		./modules/fish.nix
		./modules/alacritty.nix
		./modules/waybar.nix
		./modules/hyprpaper.nix
		./modules/hyprland.nix
		./modules/wlogout.nix
		./modules/rofi.nix
	];

	dconf.settings = {
		"org/virt-manager/virt-manager/connections" = {
			autoconnect = ["qemu:///system"];
			uris = ["qemu:///system"];
		};
	};

	# nixpkgs.config = {
	# 	packageOverrides = pkgs: {
 #        vscodium = import (builtins.fetchGit {
 #          # Descriptive name to make the store path easier to identify
 #          name = "vscodium-rev";
 #          url = "https://github.com/NixOS/nixpkgs/";
 #          ref = "refs/heads/nixpkgs-unstable";
 #          rev = "976fa3369d722e76f37c77493d99829540d43845";
 #        }) {};
	# 		# pkgs.vscodium;
	# 	};
	# };

	# nixpkgs.overlay = {
 #        vscodium = import (builtins.fetchGit {
 #          # Descriptive name to make the store path easier to identify
 #          name = "vscodium-rev";
 #          url = "https://github.com/NixOS/nixpkgs/";
 #          ref = "refs/heads/nixpkgs-unstable";
 #          rev = "976fa3369d722e76f37c77493d99829540d43845";
 #        }) { inherit system; };
	# };

	home.packages = with pkgs; [
		# firefox
		vivaldi
		vivaldi-ffmpeg-codecs
		thunderbird
		steam
		discord
		spotify
    # vscodium
    #vscodium-revision
		# (import (builtins.fetchGit {
  #     name = "vscodium";
  #     url = "https://github.com/NixOS/nixpkgs/";
  #     ref = "refs/heads/nixpkgs-unstable";
  #     rev = "976fa3369d722e76f37c77493d99829540d43845";
  #   }) {})
	  inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium
		dunst #mako		
		shotman
    # waybar
		blender
		freecad
		prusa-slicer
		obsidian
		qemu # virtualization
		virt-manager # virtualization
		github-desktop
		gimp
		speedcrunch
		#solaar
		#libratbag # dbus daemon for piper
		#piper # mouse config, depends on libratbag
		#dbus
		davinci-resolve
    #sqlite
		#anyrun.packages.x86_64-linux.anyrun-with-all-plugins
		localsend
		# rust-analyzer
		# mongodb
		mongodb-compass
    # myPkg
		# my-old-revision
	];

	home.stateVersion = "23.11";
}
