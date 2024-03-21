{ pkgs }:

pkgs.writeShellScriptBin "script-sway-notification-center" ''
  sleep 0.1
  ${pkgs.swaynotificationcenter}/bin/swaync-client -t &
''
# sleep is currently a workaround, solving the issue of
# waybar not executing the command, or executing it too 
# fast, etc
