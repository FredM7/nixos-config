{ pkgs, ... }: {
  # home.file.".config/hypr/hyprpaper.conf".text = ''
  #   preload = ~/Pictures/nixos-1.jpg
  #   preload = ~/Pictures/nixos-2.jpg
  #   wallpaper = ,~/Pictures/nixos-2.jpg
  # '';
  home.file.".config/hypr/hyprpaper.conf".text = ''
    splash = false
    preload = ~/Pictures/Backgrounds/nix-wallpaper-binary-black.png
    preload = ~/Pictures/Backgrounds/nix-wallpaper-nineish-dark-gray.png
    preload = ~/Pictures/Backgrounds/nix-wallpaper-stripes-logo.png
    wallpaper = ,~/Pictures/Backgrounds/nix-wallpaper-binary-black.png
  '';
}
