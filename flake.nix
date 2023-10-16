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
	};

	outputs = { self, nixpkgs, home-manager, hyprland, waybar, hyprpaper, ... }: {
		nixosConfigurations = {
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
								vscodium
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
