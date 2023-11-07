{ pkgs, nixpkgs, anyrun, solaar, system, inputs, ... }: let
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

	home.packages = with pkgs; [
		# firefox
		vivaldi
		vivaldi-ffmpeg-codecs
		thunderbird
		steam
		discord
		spotify
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
