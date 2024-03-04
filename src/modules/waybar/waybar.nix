{
  pkgs,
  ...
} : let
  waybarHeight = 32;
in
{
  programs.waybar.enable = true;

  programs.waybar.settings = [
    # Top bar
    {
      "name" = "top-bar";
      "height" = waybarHeight;
      "layer" = "top";
      "position" = "top";
      "modules-left" = [
        "custom/launcher"
        "custom/taskmanager"
	      "custom/hyprpicker"
        "custom/screenrecorder"
        "hyprland/window"
      ];
      "modules-center" = [
        # "group/datetimeworkspaces"
        "clock"
      ];
      "modules-right" = [
				"cpu"
				"memory"
				# "temperature#cpu"
				# "custom/gpu"
        "group/temperatures"
        "disk"
				"pulseaudio"
        # "wireplumber"
        "network"
				#"custom/pipewire"
				"custom/wlogout"
      ];
      # "group/datetimeworkspaces" = {
      #   "orientation" = "vertical";
      #   "modules" = [
      #     "clock"
      #     "hyprland/workspaces"
      #   ];
      # };
      "group/temperatures" = {
        "orientation" = "horizontal";
        "drawer" = {
          "transition-duration" = 500;
        };
        "modules" = [
          "custom/temperature-icon"
          "temperature#cpu"
          "custom/gpu"
        ];
      };
      "clock" = {
        "interval" = 1;
				# eg: 2023 Nov 13 - Tue 08:31:22
				"format" = "{:%Y %b %d - %a %H:%M:%S}";
        #"format" = "{:%Y-%m-%d %H:%M:%S}";
        "tooltip" = "true";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = " {:%d/%m}";
      };
			"cpu" = {
				"interval" = 1;
				"format" = "<span size='16pt'>󰻠</span>  <span size='10pt' rise='3pt'>{usage}%</span>";
				"tooltip" = false;
				#"format": "{icon0}{icon1}{icon2}{icon3} {usage:>2}% ",
  	    #"format-icons": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"],
			};
			"memory" = {
				"interval" = 1;
        "format" = "<span size='16pt'>󰍛</span>  <span size='10pt' rise='3pt'>{percentage}%</span>";
        "tooltip" = "false";
			};
      "custom/temperature-icon" = {
        "format" = "<span size='13.5pt'>󰏈</span>";
        "tooltip" = true;
			  "tooltip-format" = "Temperatures";
      };
    	"temperature#cpu" = {
        "thermal-zone" = 0;
        "hwmon-path" = "/sys/class/hwmon/hwmon0/temp1_input";
        "format" = "<span size='10pt' rise='2pt'>C: {temperatureC}°C</span>";
        "tooltip" = false;
    	};
    	"custom/gpu" = {
        "interval" = 1;
        "exec" = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
        "format" = "<span size='10pt' rise='2pt'>G: {}°C</span>";
        "tooltip" = false;
    	};
      "disk" = {
  	    "interval" = 30;
        "format" = "<span size='16pt'>󰋊</span>  <span size='10pt' rise='3pt'>{specific_used:0.2f} / {specific_total:0.2f} GB</span>";
        "tooltip" = false;
        "unit" = "GB";
      };
    	"hyprland/window" = {
        "format" = "{}";
        "separate-outputs" = true;
        # "rewrite" = {
        #     "(.*) — Vivaldi" = "🌎 $1";
        #     "(.*) - fish" = "> [$1]";
        # };
    	};
      "pulseaudio" = {
        "format" = "<span size='16pt'>{icon}</span>  <span size='10pt' rise='3pt'>{volume}%</span>";
				"format-muted" = "󰖁";
				"scroll-step" = 5;
				"tooltip" = false;
				"on-click" = "pavucontrol";
        "format-icons" = {
          "mute" = "";
          "default" = ["" "" "󰕾" ""];
        };
        #"exec" = "pw-volume status";
      };
      "wireplumber" = {
        "format" = "VOL2:{volume}%";
				"format-muted" = "MUT:{volume}%";
				"scroll-step" = 5;
				"tooltip" = false;
				"on-click" = "pavucontrol";
      };
			# https://www.mankier.com/5/waybar-network
			"network" = {
			  "format" = "{ifname}";
			  "format-wifi" = " {signalStrength}%";
			  "format-ethernet" = "󰈀";
			  # "format-disconnected" = ""; //An empty format will hide the module.
			  "format-disconnected" = "NO NET";
			  "tooltip-format" = "{ifname}\nIP:{ipaddr}";
			  "tooltip-format-wifi" = "{essid} ({signalStrength}%)\nD:{bandwidthDownBytes} U:{bandwidthUpBytes}\nIP:{ipaddr}";
			  "tooltip-format-ethernet" = "{ifname}\nD:{bandwidthDownBytes} U:{bandwidthUpBytes}\nIP:{ipaddr}";
			  "tooltip-format-disconnected" = "Disconnected";
				"interval" = 1;
			  "max-length" = 50;
			};
      "custom/launcher" = {
        "format" = "";
        "on-click" = "sleep 0.1 && rofi -show drun"; # sleep is currently a workaround
        # "max-length" = "2";
      };
      "custom/taskmanager" = {
        "format" = "";
        "on-click" = "sleep 0.1 && alacritty --class Btop -e btop"; # sleep is currently a workaround
      };
      "custom/hyprpicker" = {
        "format" = "󰈋";
        "on-click" = "sleep 0.1 && hyprpicker -a -f hex"; # sleep is currently a workaround
        # "on-click-right" = "hyprpicker -a -f rgb";
      };
      "custom/screenrecorder" = {
        "format" = "󰕧";
        "on-click" = "sleep 0.1 && kooha"; # sleep is currently a workaround
      };
      "custom/wlogout" = {
        "format" = "󰐦";
        "on-click" = "sleep 0.1 && wlogout"; # sleep is currently a workaround
      };
    }
    # Bottom bar
    {
      "name" = "bottom-bar";
      "height" = waybarHeight;
      "layer" = "top";
      "position" = "bottom";
      "modules-left" = [
        "wlr/taskbar"
      ];
      "modules-center" = [
        "hyprland/workspaces"
      ];
      "modules-right" = [
				"custom/bluetooth"
        "tray"
      ];
      "tray" = {
        "icon-size" = 24;
        "spacing" = 8;
      };
      "custom/bluetooth" = {
        "format" = " ";
        "on-click" = "sleep 0.1 && alacritty --class Bluetuith -e bluetuith"; # sleep is currently a workaround
      };
      "wlr/taskbar" = {
        #"icon-theme" = "Numix-Circle";
        "icon-size" = 14;
        "on-click" = "activate";
        # "on-click-right" = "close";
        "on-click-middle" = "close";
        #"format" = "{icon}";
        "ignore-list" = [
          # "Alacritty"
        ];
      };
    	"hyprland/workspaces" = {
        "format" = "";
        # "on-click" = "activate";
        # "all-outputs" = true;
        "persistent-workspaces" = {
          # "1" = ["DVI-I-1"];
          # "2" = ["DVI-I-1"];
          # "3" = ["HDMI-A-1"];
          # "4" = ["HDMI-A-1"];
          "DVI-I-1" = [ 1 2 3 ];
          "HDMI-A-1" = [ 4 5 6 ];
        };
    	};
    }
  ];

  programs.waybar.style = builtins.readFile ./style.css;
}
