{
  pkgs,
  username,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      # README: https://man.sr.ht/~kennylevinsen/greetd/
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland
        '';
      };
      
      initial_session = {
        command = "Hyprland";
	      user = username;
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}

