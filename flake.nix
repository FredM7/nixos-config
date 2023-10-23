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
	};

	outputs = { self, nixpkgs, home-manager, hyprland, waybar, hyprpaper, anyrun, ... }@inputs: 
	let 
	in
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
    #imports = [
    #  anyrun.homeManagerModules.default
		#];

		nixosConfigurations = {
		  #HOSTNAME = nixpkgs.lib.nixosSystem {
      #  # ...
      #  system.packages = [ anyrun.packages.x86_64-linux.anyrun ];
      #  # ...
      #};

			fred = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				#system.packages = [
        #  anyrun.packages.x86_64-linux.anyrun
				#];
				modules = [
					./configuration.nix
					./modules/greetd.nix
					#anyrun.homeManagerModules.default
					#./modules/anyrun.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;

						home-manager.users.fred = import ./home.nix;

						home-manager.extraSpecialArgs = {
              inherit anyrun;
						};
					}
				];
			};
		};
	};
}
