{ pkgs, nixpkgs, anyrun, solaar, system, 
# xdg-desktop-portal-hyprland, 
inputs, ... }: let
  #
in {
	home.username = "fred";
	home.homeDirectory = "/home/fred";

	programs.home-manager.enable = true;

	imports = [
	  # ./modules/xdg-desktop-portal-hyprland.nix
		./modules/codium.nix
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
	
	home.packages = with pkgs; [
		vivaldi
		vivaldi-ffmpeg-codecs
		thunderbird
		steam
		discord
		spotify
    # inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium
		# rust.packages.stable.rustPlatform.rustcSrc
		dunst #mako		
		shotman
		blender
		freecad
		prusa-slicer
		obsidian
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
