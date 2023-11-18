{ pkgs, ... }: {
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/nixos-1.jpg
    preload = ~/Pictures/nixos-2.jpg
    wallpaper = ,~/Pictures/nixos-2.jpg
  '';
}
