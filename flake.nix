{
	description = "Fred's Flakes";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";

		waybar.url = "github:Alexays/Waybar";

		hyprpaper = {
			url = "github:hyprwm/hyprpaper";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#anyrun = {
    #  url = "github:Kirottu/anyrun";
    #  inputs.nixpkgs.follows = "nixpkgs";
		#};
	};

	outputs = { self, nixpkgs, home-manager, hyprland, waybar, hyprpaper, 
	#anyrun, 
	... }: 
	#let 
	#in
  #let
  #   asd = builtins.currentSystem;
	#	 
  #
  #   pkgs = import (builtins.fetchGit {
  #       # Descriptive name to make the store path easier to identify
  #       name = "vscodium-rev";
  #       url = "https://github.com/NixOS/nixpkgs/";
  #       ref = "refs/heads/nixpkgs-unstable";
  #       rev = "976fa3369d722e76f37c77493d99829540d43845";
  #   }) { 
  #			inherit asd;
	#	 };
  #
  #  vscodium-revision = pkgs.vscodium;
  #in
	{
		nixosConfigurations = {
		  #HOSTNAME = nixpkgs.lib.nixosSystem {
      #  # ...
      #  #system.packages = [ anyrun.packages.x86_64-linux.anyrun ];
      #  # ...
      #};

			fred = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./configuration.nix
					./modules/greetd.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;

						home-manager.users.fred = { pkgs, ... }: {
							home.username = "fred";
							home.homeDirectory = "/home/fred";

							programs.home-manager.enable = true;

							imports = [
								./modules/fishsh.nix
								./modules/alacritty.nix
								./modules/waybar.nix
								./modules/hyprpaper.nix
								./modules/hyprland.nix
								./modules/wlogout.nix
							];

							dconf.settings = {
								"org/virt-manager/virt-manager/connections" = {
									autoconnect = ["qemu:///system"];
									uris = ["qemu:///system"];
								};
							};

							home.packages = with pkgs; [
								firefox
								vivaldi
								vivaldi-ffmpeg-codecs
								thunderbird
								steam
								discord
								spotify
								#vscodium
								#vscodium-revision
								dunst #mako		
								shotman
                # waybar
								blender
								freecad
								obsidian
								qemu # virtualization
								virt-manager # virtualization
								github-desktop
							];

							home.stateVersion = "23.11";
						};
					}
				];
			};
		};
	};
}
