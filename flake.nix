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

		anyrun = {
      url = "github:Kirottu/anyrun";
      # url = "github:Kirottu/anyrun/homeManagerModules.default";
      inputs.nixpkgs.follows = "nixpkgs";
		};

		nixpkgs-vscodium.url = "github:nixos/nixpkgs/976fa3369d722e76f37c77493d99829540d43845";

		#solaar = {
		#	url = "https://github.com/Svenum/Solaar-Flake/tree/release-1.1.10"; # For latest stable version
		#	# url = "https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.10"; # For latest stable version
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
	};

	outputs = { 
	  self,
		nixpkgs,
		home-manager,
		hyprland,
		waybar,
		hyprpaper,
		anyrun, 
	  #solaar, 
	  ...
	} @ inputs: 
	# let
	#   #
	# in
  # let
  #   pkgs = import (builtins.fetchGit {
  #       # Descriptive name to make the store path easier to identify
  #       name = "vscodium-rev";
  #       url = "https://github.com/NixOS/nixpkgs/";
  #       ref = "refs/heads/nixpkgs-unstable";
  #       rev = "976fa3369d722e76f37c77493d99829540d43845";
  #   }) {};
  #
  #   vscodium-rev = pkgs.vscodium;
  # in
# 	let
# 	system = "x86_64-linux";
#
#   pkgs = import (builtins.fetchGit {
#     # Descriptive name to make the store path easier to identify
#     name = "my-old-revision";
#     url = "https://github.com/NixOS/nixpkgs/";
#     ref = "refs/heads/nixpkgs-unstable";
#     rev = "976fa3369d722e76f37c77493d99829540d43845";
#   }) { 
#     inherit system;
# 	};
#
#   myPkg = pkgs.vscodium;
# in

	{
    nixosConfigurations = {
			fred = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				
				modules = [
					./configuration.nix
					./modules/greetd.nix
					#({pkgs, ...}: {
          #  # environment.systemPackages = [solaar.packages.${pkgs.system}.solaar];
          #  environment.systemPackage = [ myPkg ];
					#})
          # myPkg
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;

						home-manager.users.fred = import ./home.nix;

						home-manager.extraSpecialArgs = {
              inherit anyrun inputs;
							# inherit myPkg;
						};
					}
				];
			};
		};
	};
}
