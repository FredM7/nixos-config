{ ... }: {
#   home.file.".config/alacritty/alacritty.yml".text = ''
# font:
#   normal:
#     family: EnvyCodeR Nerd Font
#     style: Regular
# '';
  home.file.".config/alacritty/" = {
    source = ./../configs/alacritty;
    recursive = true;
  };
}
