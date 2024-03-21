{ pkgs }:

pkgs.writeShellScriptBin "script-rofi" ''
  sleep 0.1
  ${pkgs.rofi-wayland} -show drun
''
# sleep is currently a workaround, solving the issue of
# waybar not executing the command, or executing it too 
# fast, etc
