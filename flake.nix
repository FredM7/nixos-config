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

	anyrun = {
	  url = "github:Kirottu/anyrun";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	nixpkgs-vscodium.url = "github:nixos/nixpkgs/976fa3369d722e76f37c77493d99829540d43845";

	nixpkgs-obsidian.url = "github:nixos/nixpkgs/4ab8a3de296914f3b631121e9ce3884f1d34e1e5";

	solaar = {
	  url = "github:Svenum/Solaar-Flake/main";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
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
	anyrun, 
	solaar, 
	...
  } @ inputs: let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
	  fred = nixpkgs.lib.nixosSystem rec {
		modules = [
		  solaar.nixosModules.default
		  ./src/configuration.nix
		  ./src/modules/greetd.nix
		  ./src/modules/logid.nix
		  # hyprland.homeManagerModules.default
		  home-manager.nixosModules.home-manager {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;

			home-manager.users.fred = import ./src/home.nix;

			home-manager.extraSpecialArgs = {
			  inherit anyrun inputs nixpkgs-obsidian nixpkgs-vscodium; # xdg-desktop-portal-hyprland; # hyprland;
			};
		  }
		];
	  };
	};
	
	devShells.x86_64-linux.default = (import ./src/shell.nix { inherit pkgs; });
  };
}
