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
				"custom/wlogout"
        "custom/launcher"
	      "custom/hyprpicker"
        "hyprland/window"
      ];
      "modules-center" = [
        # "group/datetimeworkspaces"
        "clock"
      ];
      "modules-right" = [
				"cpu"
				"memory"
				"temperature#cpu"
				"custom/gpu"
        "disk"
				"pulseaudio"
        # "wireplumber"
        "network"
				#"custom/pipewire"
      ];
      # "group/datetimeworkspaces" = {
      #   "orientation" = "vertical";
      #   "modules" = [
      #     "clock"
      #     "hyprland/workspaces"
      #   ];
      # };
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
    	"temperature#cpu" = {
        "thermal-zone" = 0;
        "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
        "format" = "CPUT:{temperatureC}°C";
        "tooltip" = false;
    	};
    	"custom/gpu" = {
        "interval" = 1;
        "exec" = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
        "format" = "<span size='13.5pt'>󰏈</span>   <span size='10pt' rise='2pt'>{}°C</span>";
        "tooltip" = false;
    	};
      "disk" = {
  	    "interval" = 30;
        "format" = "<span size='16pt'>󰋊</span>  <span size='10pt' rise='3pt'>{specific_used:0.2f} / {specific_total:0.2f} GB</span>";
        "tooltip" = false;
        "unit" = "GB";
      };
    	"hyprland/workspaces" = {
        "format" = "";
        # "all-outputs" = true;
    	};
    	"hyprland/window" = {
        "format" = "{}";
        "separate-outputs" = true;
        # "rewrite" = {
        #     "(.*) — Vivaldi" = "🌎 $1";
        #     "(.*) - fish" = "> [$1]";
        # };
    	};
      "wlr/taskbar" = {
        #"icon-theme" = "Numix-Circle";
        "icon-size" = 12;
        "on-click" = "activate";
        "on-click-right" = "minimize";
        #"format" = "{icon}";
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
    }
  ];

  programs.waybar.style = ''
    * {
      min-height: 0px;
      padding: 0;
      margin: 0;
    }

    window#waybar {
      background-color: transparent;
      color: #ffffff;
      transition-property: background-color;
      transition-duration: .5s;
    }

		.modules-left {

		}

		.modules-center {
      /*margin-top: 8px;
      border: 1px solid white;
      border-radius: 5px;
      justify-content: center;
      text-align: center;
      min-width: 200px;
      background-color: red;*/
		}

		.modules-right {
      padding-right: 8px;
		}

    #custom-wlogout, #custom-launcher, #custom-hyprpicker {
      color: white;
      border: 1px solid white;
      border-radius: 100px;
      min-width: 32px;
      font-size: 18px;
      padding: 0;
      margin: 0;
      min-height: 0px;
    }

    #workspaces {
      min-height: 0px;
      font-size: 0px;
    }

    #workspaces button {
      background-color: transparent;
      color: #ffffff;
      background-color: orange;
      border-radius: 100px;
      min-width: 5px;
      min-height: 5px;
      padding: 0;
      /*margin-top: 13px;
      margin-bottom: 13px;*/
      font-size: 0px;
    }

    #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.active {
      background-color: red;
      border-radius: 100px;
      min-width: 10px;
    }

    #workspaces button.focused {
      background-color: #64727D;
      box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
      background-color: #eb4d4b;
    }

    #clock {
      /*  padding: 10px; */
      color: white;
      /* border: 1px solid white;
      border-radius: 100px; */
      font-size: 13px;
    }

		#cpu, #memory, #temperature.cpu, #custom-gpu {
		  padding-left: 15px;
      font-size: 13px;
		}

    #disk {
      padding-left: 15px;
			color: white;
      font-size: 13px;
    }

    #pulseaudio, #wireplumber {
      /*background-color: #f1c40f;
      color: #000000;*/
      /*font-size: 20px;*/
		  padding-left: 15px;
			color: white;
      min-width: 24px;
    }

		#network {
			padding-left: 15px;
      font-size: 20px;
      min-width: 24px;
		}

    #pulseaudio.muted, #wireplumber.muted {
      /*background-color: #90b1b1;
      color: #2a5c45;*/
    }

		#tray {
		  padding-left: 4px;
      /*font-size: 8px;
			padding-right: 8px;*/
		}

		#custom-bluetooth {
		  padding-left: 15px;
      font-size: 18px;
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
