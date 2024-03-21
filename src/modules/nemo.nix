{
  lib,
  pkgs,
  ...
}: let
  fakeGnomeTerminal = pkgs.writeShellApplication {
    name = "gnome-terminal";
    text = ''${lib.getExe pkgs.alacritty} -e "$@"'';
  };
  nemo-patched = pkgs.cinnamon.nemo-with-extensions.overrideAttrs (_: {
    postFixup = ''
      wrapProgram $out/bin/nemo \
        --prefix PATH : "${lib.makeBinPath [ fakeGnomeTerminal ]}"
    '';
  });
in {
  home = {
    packages = with pkgs; [
      cinnamon.nemo-fileroller
      nemo-patched
    ];
  };

  xdg = {
    mimeApps.defaultApplications =
      {
        # "inode/directory" = "nemo.desktop";
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/vnd.rar" = "org.gnome.FileRoller.desktop";
        "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      };
  };

  dconf.settings = {
    "org/gnome/desktop/applications/terminal" = {
      exec = lib.getExe pkgs.alacritty;
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = lib.getExe pkgs.alacritty;
    };
    "org/nemo/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = true;
    };
    "org/nemo/window-state" = {
      sidebar-width = 220;
    };
  };
}
