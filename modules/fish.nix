{ pkgs, ... }: {
  programs.fish = {
    enable = true; # Fish also enabled in configuratiion.nix programs.
		interactiveShellInit = ''
      set fish_greeting
      screenfetch -E
    '';
  };
}

