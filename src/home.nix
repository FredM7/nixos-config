{ pkgs, nixpkgs, anyrun, solaar, system, nixpkgs-obsidian, 
	inputs, username, cursorsize, ...
}: let
	oreo-cursor = pkgs.callPackage ./derivations/oreo-cursor.nix {};
	otis = pkgs.callPackage ./derivations/otis.nix {};
	# my-piper = pkgs.callPackage ./derivations/piper.nix {};
	# logiops-pkg = pkgs.callPackage ./derivations/logiops.nix {};
	# docker-desktop = pkgs.callPackage ./derivations/docker-desktop.nix {};
  in {
	home.username = username;
	home.homeDirectory = "/home/${username}";

	programs.home-manager.enable = true;

	gtk = {
		enable = true;

		cursorTheme = {
			package = oreo-cursor;
			name = "oreo_spark_lime_cursors";
			size = cursorsize;
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

	xdg = {
		desktopEntries.github-desktop = {
			name = "GitHub Desktop";
			genericName = "GitHub Desktop";
			comment = "Simple collabortion from your desktop";
			icon = "github-desktop";
			type = "Application";
			startupNotify = true;
			exec = "github-desktop --disable-gpu %U";
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
		size = cursorsize;
		gtk.enable = true;
      	x11.enable = true;
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
		# teams
		spotify
		# dunst #mako
		grim # screenshot
		slurp # screenshot area selection
		swappy # screenshot editor
		kooha # screen recorder
		blender
		freecad
		prusa-slicer
		(import nixpkgs-obsidian {
			system = pkgs.system;
			config.allowUnfree = true;
		}).obsidian
		qemu # virtualization
		virt-manager # virtualization
		quickemu
		quickgui
		# distrobox
		# virtualbox
		github-desktop
		gimp
		speedcrunch
		obs-studio
		# logiops
		# logiops-pkg
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
		# heroic-unwrapped
		heroic
		gogdl
		# logiops
		ledger-live-desktop
		android-studio
		# postman
	];

	home.stateVersion = "23.11";
}
