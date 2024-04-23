{ pkgs, ... }: {
  home.file = {
    ".config/hypr/" = {
      # hypridle, hyprpaper, etc
      source = ./../configs/hypr;
      recursive = true;
    };

    ".config/alacritty/" = {
      source = ./../configs/alacritty;
      recursive = true;
    };

    "./.config/nvim/" = {
      source = ./../configs/nvim;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ./../configs/rofi;
      recursive = true;
    };

    ".config/swappy/" = {
      source = ./../configs/swappy;
      recursive = true;
    };
  };
}
