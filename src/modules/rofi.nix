{ pkgs, ... }: {
  home.file.".config/rofi/" = {
    source = ./../configs/rofi;
    recursive = true;
  };
}
