{ pkgs, nixpkgs, anyrun, solaar, system, nixpkgs-obsidian, 
#   xdg-desktop-portal-hyprland,
  inputs, ... }: let
	# oreo-cursor = import ./derivations/oreo-cursor.nix { inherit pkgs; };
	oreo-cursor = pkgs.callPackage ./derivations/oreo-cursor.nix {};
  in {
	home.username = "fred";
	home.homeDirectory = "/home/fred";

	programs.home-manager.enable = true;

	gtk = {
		enable = true;
		# cursorTheme = "Adwaita";
	};
	
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
		name = "Spark-Black";
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
		qemu # virtualization
		virt-manager # virtualization
		github-desktop
		gimp
		speedcrunch
		obs-studio
		#solaar
		#libratbag # dbus daemon for piper
		#piper # mouse config, depends on libratbag
		davinci-resolve
		audacity
		localsend
		# rust-analyzer
		# mongodb
		mongodb-compass
		# inputs.solaar
		piper
    	# inputs.xdg-desktop-portal-hyprland
	];

	home.stateVersion = "23.11";
}
