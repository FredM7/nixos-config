{
  description = "Fred's NixOS Configuration";

  inputs = rec {
	nixpkgs = {
	  url = "github:NixOS/nixpkgs/nixos-unstable";
	};
	home-manager = {
	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	hyprland = {
	  url = "github:hyprwm/Hyprland";
	};

	waybar = {
	  url = "github:Alexays/Waybar";
	};

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
	# USER
	username = "fred";
	hostname = "nixos";
	# SYSTEM
	cursorsize = 24; # 24, 32, 40, 48, 56, 64
  in {
    nixosConfigurations = {
	  ${username} = nixpkgs.lib.nixosSystem {
		specialArgs = {
		  inherit username;
		  inherit system;
		  inherit hostname;
		  inherit cursorsize;
		};

		modules = [
		  ./src/configuration.nix
		  ./src/modules/greetd.nix
		  ./src/modules/logid.nix
		  solaar.nixosModules.default
		  home-manager.nixosModules.home-manager {
			home-manager = {
			  extraSpecialArgs = {
				inherit username cursorsize;
				inherit anyrun inputs nixpkgs-obsidian nixpkgs-vscodium;
			  };

			  useGlobalPkgs = true;
			  useUserPackages = true;

			  users.${username} = import ./src/home.nix;
			};
		  }
		];
	  };
	};
	
	# devShells.${system}.default = (import ./src/shell.nix { inherit pkgs; });
  };
}
