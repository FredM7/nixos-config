{
  pkgs,
  username,
  ...
}:
{
  security.pam.services.greetd.enableGnomeKeyring = true;
  
  services.greetd = {
    enable = true;
    vt = 2; # The virtual console (tty) that greetd should use.
    settings = {
      # README: https://man.sr.ht/~kennylevinsen/greetd/
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --remember \
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

