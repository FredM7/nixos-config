{ pkgs, nixpkgs, anyrun, solaar, system, nixpkgs-obsidian, 
  # xdg-desktop-portal-hyprland, 
  inputs, ... }: let
	oreo-cursor = pkgs.callPackage ./derivations/oreo-cursor.nix {};
  in {
	home.username = "fred";
	home.homeDirectory = "/home/fred";

	programs.home-manager.enable = true;

	gtk = {
		enable = true;
		# cursorTheme = "Adwaita";
	};

	# imports = [
	# 	xdg-desktop-portal-hyprland.homeManagerModules.default
	# ];
	
	# xdg-desktop-portal-hyprland.homeManagerModules = {
	# 	enable = true;	
	# };
	
	# qt = {
	# 	enable = true;
	# };

	# home.pointerCursor = {
	# 	name = "Bibata-Modern-Amber";
	# 	package = pkgs.bibata-cursors;
	# 	size = 10;
	# 	gtk.enable = true;
	# 	# qt.enable = true;
	# 	# x11.enable = true;
	# };
	home.pointerCursor = {
		# find the name of the cursor theme by looking in:
		# /etc/profiles/per-user/<your_username>/share/icons
		name = "oreo_spark_lime_cursors";
		package = oreo-cursor;
		size = 10;
		# gtk.enable = true;
		# qt.enable = true;
		# x11.enable = true;
	};

	imports = [
	  	# ./modules/xdg-desktop-portal-hyprland.nix
		./modules/codium.nix
		# ./modules/obsidian.nix
	  	./modules/nvim.nix
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

	# services.gnome-keyring = {
 #    enable = true;
	# };
	
	home.packages = with pkgs; [
		vivaldi
		vivaldi-ffmpeg-codecs
		thunderbird
		steam
		discord
		webcord
		spotify
    	# inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium
		# rust.packages.stable.rustPlatform.rustcSrc
		# inputs.nixpkgs-obsidian.legacyPackages.x86_64-linux.obsidian
		dunst #mako
		grim # screenshot
		slurp # screenshot area selection
		swappy # screenshot editor
		blender
		freecad
		prusa-slicer
		# obsidian
		# nixpkgs-obsidian.legacyPackages.${pkgs.system}.obsidian
		# nixpkgs-obsidian
		(import nixpkgs-obsidian {
			system = pkgs.system;
			config.allowUnfree = true;
		}).obsidian
		# (import xdg-desktop-portal-hyprland {
		# 	system = pkgs.system;
		# 	config.allowUnfree = true;
		# }).
		# xdg-desktop-portal-hyprland
		qemu # virtualization
		virt-manager # virtualization
		# virtualbox
		github-desktop
		gimp
		speedcrunch
		obs-studio
		#solaar
		#libratbag # dbus daemon for piper
		#piper # mouse config, depends on libratbag
		# davinci-resolve
    	libsForQt5.kdenlive
		audacity
		localsend
		# rust-analyzer
		# mongodb
		mongodb-compass
		# inputs.solaar
		piper
		vlc
		gparted # partition manager
		partition-manager
		mediawriter # for flashing SD cards
		rpi-imager # for flashing PI Images
    	# inputs.xdg-desktop-portal-hyprland
	];

	home.stateVersion = "23.11";
}
