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

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # nixpkgs-hyprland = {
    #   url = "github:hyprwm/Hyprland/f3c92e75c8746901898b59abf2a1412bb16cbb54";
    #   # url = "github:hyprwm/Hyprland/v0.36.0";
    #   # url = "github:nixos/nixpkgs/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3";
    # };
    nixpkgs-hyprland.url = "github:nixos/nixpkgs/9e343b8635964e7155e544473e5c760af2778d4e";

    waybar = {
      url = "github:Alexays/Waybar";
    };

    nixpkgs-vscodium.url = "github:nixos/nixpkgs/976fa3369d722e76f37c77493d99829540d43845";

    nixpkgs-obsidian.url = "github:nixos/nixpkgs/4ab8a3de296914f3b631121e9ce3884f1d34e1e5";

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { 
    self,
    nixpkgs,
    home-manager,
    # hyprland,
    nixpkgs-hyprland,
    waybar,
    nixpkgs-vscodium,
    nixpkgs-obsidian,
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
          inherit inputs;
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
                inherit inputs nixpkgs-obsidian nixpkgs-vscodium nixpkgs-hyprland;
              };

              useGlobalPkgs = true;
              useUserPackages = true;

              users.${username} = import ./src/home.nix;
            };
          }
        ];
      };
    };
  };
}
