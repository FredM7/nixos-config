{
  pkgs,
  ...
} :
{
  programs.waybar.enable = true;
  programs.waybar.settings = [ 
    {
      #"height" = 16;
      "layer" = "top";
      "position" = "top";
      "modules-left" = [
        "custom/launcher"
	      "custom/hyprpicker"
				"hyprland/workspaces"
        "wlr/taskbar"
      ];
      "modules-center" = [
        "tray"
      ];
      "modules-right" = [
        "network"
				"cpu"
				"memory"
				"custom/bluetooth"
				"pulseaudio"
				"custom/pipewire"
				"clock"
				"custom/wlogout"
      ];
      "clock" = {
        "interval" = 1;
        "format" = "{:%Y-%m-%d %H:%M:%S}";
        "tooltip" = "true";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = " {:%d/%m}";
      };
      "wlr/taskbar" = {
        #"icon-theme" = "Numix-Circle";
        "icon-size" = 12;
        "on-click" = "activate";
        "on-click-right" = "minimize";
        #"format" = "{icon}";
      };
      "custom/pipewire" = {
        "format" = "{icon}";
        "return-type" = "json";
        "signal" = 8;
        "interval" = "once";
        "format-icons" = {
          "mute" = "";
          "default" = ["" "" "" ""];
        };
        "exec" = "pw-volume status";
      };
      "custom/bluetooth" = {
        "format" = "BT";
        "on-click" = "sleep 0.1 && alacritty --class Bluetuith -e bluetuith"; # sleep is currently a workaround
      };
      "custom/launcher" = {
        "format" = "󰈸";
        "on-click" = "sleep 0.1 && rofi -show drun"; # sleep is currently a workaround
        # "max-length" = "2";
      };
      "custom/hyprpicker" = {
        "format" = "󰈋";
        "on-click" = "sleep 0.1 && hyprpicker -a -f hex"; # sleep is currently a workaround
        # "on-click-right" = "hyprpicker -a -f rgb";
      };
      "custom/wlogout" = {
        "format" = "⏻";
        "on-click" = "sleep 0.1 && wlogout"; # sleep is currently a workaround
      };
    }
  ];

  programs.waybar.style = ''
    * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: FontAwesome; /* , Roboto, Helvetica, Arial, sans-serif; */
      font-size: 13px;
    }

    window#waybar {
      background-color: transparent;
      /* border-bottom: 1px solid #ffffff; */
      color: #ffffff;
      transition-property: background-color;
      transition-duration: .5s;
    }

    #clock {
      padding: 10px;
      color: white;
      border: 1px solid white;
      border-radius: 100px;
    }

    #workspaces button {
      padding: 0 5px;
      background-color: transparent;
      color: #ffffff;
    }

    #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.focused {
      background-color: #64727D;
      box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
      background-color: #eb4d4b;
    }

    #pulseaudio {
      background-color: #f1c40f;
      color: #000000;
    }

    #pulseaudio.muted {
      background-color: #90b1b1;
      color: #2a5c45;
    }

    #custom-launcher, #custom-hyprpicker, #custom-wlogout {
      /* padding: 10px;
			height: 40px; 
			width: 40px; */
			min-width: 32px;
			min-height: 32px;
      color: white;
      border: 1px solid white;
      border-radius: 100px;
      min-width: 32px;
    }

    #taskbar {
      border-radius: 0px 8px 8px 0;
      padding: 0 3px;
      margin: 0 0px;
      color: #ffffff;
      background-color: rgba(120,118,117,0.3);
    }
    #taskbar button {
      border-radius: 3px 3px 3px 3px;
      padding: 0 0 0 3px;
      margin: 3px 1;
      color: #ffffff;
      background-color: rgba(120,118,117,0.1);
    }
    #taskbar button.active {
      background-color: rgba(120,118,117,0.8);
    }
  '';
}
