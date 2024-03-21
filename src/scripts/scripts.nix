{ pkgs, ... }: {
  home.packages = with pkgs; [
    (import ./rofi.nix { inherit pkgs; })
  ];
}
