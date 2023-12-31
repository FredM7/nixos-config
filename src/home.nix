{ pkgs, nixpkgs, anyrun, solaar, system, nixpkgs-obsidian, inputs, ... }: let
	oreo-cursor = pkgs.callPackage ./derivations/oreo-cursor.nix {};
	otis = pkgs.callPackage ./derivations/otis.nix {};
	# my-piper = pkgs.callPackage ./derivations/piper.nix {};
	# logiops = pkgs.callPackage ./derivations/logiops.nix {};
	# docker-desktop = pkgs.callPackage ./derivations/docker-desktop.nix {};
  in {
	home.username = "fred";
	home.homeDirectory = "/home/fred";

	programs.home-manager.enable = true;

	gtk = {
		enable = true;

		cursorTheme = {
			package = oreo-cursor;
			name = "oreo_spark_lime_cursors";
		};

		theme = {
			name = "otis";
			package = otis;
		};

		iconTheme = {
			# name = "WhiteSur-icon-theme";
			name = "Tela-pink-dark";
			# package = pkgs.whitesur-icon-theme;
			package = pkgs.tela-icon-theme;
		};
	};

	# qt = {
	# 	enable = true;
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
		./modules/dunst.nix
		./modules/codium.nix
		# ./modules/obsidian.nix
	  	./modules/nvim.nix
		./modules/anyrun.nix
		./modules/fish.nix
		./modules/alacritty.nix
		./modules/waybar/waybar.nix
		./modules/hyprpaper.nix
		./modules/hyprland.nix
		./modules/wlogout.nix
		./modules/rofi.nix
		# ./modules/logid.nix
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

	# home.packages = [ piper ];
	
	home.packages = with pkgs; [
		vivaldi
		vivaldi-ffmpeg-codecs
		floorp
		thunderbird
		steam
		discord
		webcord
		spotify
		# dunst #mako
		grim # screenshot
		slurp # screenshot area selection
		swappy # screenshot editor
		blender
		freecad
		prusa-slicer
		(import nixpkgs-obsidian {
			system = pkgs.system;
			config.allowUnfree = true;
		}).obsidian
		qemu # virtualization
		virt-manager # virtualization
		# virtualbox
		github-desktop
		gimp
		speedcrunch
		obs-studio
		logiops
		# davinci-resolve
    	libsForQt5.kdenlive
		audacity
		localsend
		mongodb-compass
		piper
		vlc
		gparted # partition manager
		partition-manager
		mediawriter # for flashing SD cards
		rpi-imager # for flashing PI Images
		# docker-desktop
		distrobox
		# heroic-unwrapped
		heroic
		gogdl
		# logiops
		ledger-live-desktop
	];

	home.stateVersion = "23.11";
}
