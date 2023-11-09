{ ... }: {
  home.file."./.config/nvim/" = {
    source = ./../configs/nvim;
    recursive = true;
  };
}
