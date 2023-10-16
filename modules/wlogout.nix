{ pkgs, ... }:{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "reboot";
	action = "systemctl reboot";
	text= "Reboot";
	keybind = "r";
      }
      {
        label = "shutdown";
	action = "systemctl poweroff";
	text= "Shutdown";
	keybind = "s";
      }
      {
        label = "lock";
        action = "hyprctl dispatch exit";
        text = "Lock";
        keybind = "l";
      }
    ];
  };
}
