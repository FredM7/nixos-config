{
	description = "Fred's Flakes";

	inputs = rec {
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

		# xdg-desktop-portal-hyprland = {
      	# 	url = "github:hyprwm/xdg-desktop-portal-hyprland";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

		anyrun = {
      		url = "github:Kirottu/anyrun";
      		# url = "github:Kirottu/anyrun/homeManagerModules.default";
      		inputs.nixpkgs.follows = "nixpkgs";
		};

		nixpkgs-vscodium.url = "github:nixos/nixpkgs/976fa3369d722e76f37c77493d99829540d43845";

		nixpkgs-obsidian.url = "github:nixos/nixpkgs/4ab8a3de296914f3b631121e9ce3884f1d34e1e5";

		# solaar = {
		#   url = "github:Svenum/Solaar-Flake/release-1.1.10"; # For latest stable version
  #     inputs.nixpkgs.follows = "nixpkgs";
  #   };
	};

	outputs = { 
	  	self,
		nixpkgs,
		home-manager,
		hyprland,
		waybar,
		hyprpaper,
		nixpkgs-vscodium,
		nixpkgs-obsidian,
		# xdg-desktop-portal-hyprland,
		anyrun, 
	  # solaar, 
	  ...
	} @ inputs: let
    #
	in {
		# homeConfigurations."fred" = home-manager.lib.homeManagerConfiguration {
		
		# };
    	nixosConfigurations = {
			fred = nixpkgs.lib.nixosSystem rec {
				system = "x86_64-linux";

				# specialArgs = {
				# 	pkgs-obsidian = import nixpkgs-obsidian {
				# 		system = "x86_64-linux";
				# 		config.allowUnfree = true;
				# 	};
				# };

				modules = [
					./src/configuration.nix
					./src/modules/greetd.nix
					# hyprland.homeManagerModules.default
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;

						home-manager.users.fred = import ./src/home.nix;

						home-manager.extraSpecialArgs = {
							inherit anyrun inputs nixpkgs-obsidian nixpkgs-vscodium; # xdg-desktop-portal-hyprland; # hyprland; # solaar
						};
					}
				];
			};
		};
	};
}
