{ pkgs, ... }: {
  home.file.".config/rofi/config.rasi" = {
    source = ./../configs/rofi/config.rasi;
    recursive = false;
  };
}
