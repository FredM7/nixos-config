{ pkgs, ... }: {
  home.file.".config/hypr/" = {
    # hypridle, hyprpaper, etc
    source = ./../configs/hypr;
    recursive = true;
  };

  home.file.".config/alacritty/" = {
    source = ./../configs/alacritty;
    recursive = true;
  };

  home.file."./.config/nvim/" = {
    source = ./../configs/nvim;
    recursive = true;
  };

  home.file.".config/rofi/" = {
    source = ./../configs/rofi;
    recursive = true;
  };

  home.file.".config/swappy/" = {
    source = ./../configs/swappy;
    recursive = true;
  };
}
