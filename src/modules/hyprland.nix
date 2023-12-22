{ pkgs, hyprland, ... }: {
  wayland.windowManager.hyprland = {
  # imports = [
  #   hyprland.homeManagerModules.default
  # ];

  # programs.hyprland = {
    enable = true;

    enableNvidiaPatches = true;
    xwayland.enable = true;

    settings = {
		  # https://wiki.hyprland.org/Configuring/Variables/

      monitor = [
        "DVI-I-1,1920x1080@144,0x0,1"
        "HDMI-A-1,1920x1080@144,1920x0,1"
      ];

      decoration = {
        rounding = 8;
        #inactive_opacity = 0.8;
        drop_shadow = true;
        # dim_inactive = true;
        # dim_strength = 0.2;
      };

      general = {
        border_size = 1;
        gaps_in = 4;
        gaps_out = 6;
      };

			
			input = {
        follow_mouse = 2;
			};

			misc = {
        mouse_move_enables_dpms = true;
				#key_press_enables_dpms = true;
			};
      #source = [
      #  #./binds.nix
#	#./windowrules.nix
#	/startup.conf
#      ];

      #imports = [
        #./modules/hyprland/binds.nix
	#./windowrules.nix
#	./startup.nix
 #     ];

      "$mod" = "SUPER";
  
      bind = [
        "$mod, Q, exec, alacritty"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, C, killactive,"
        "$mod, T, togglefloating,"
        "$mod, S, swapnext,"
				"$mod, F, fullscreen, 0"
				"$mod, M, fullscreen, 1"
        "$mod, B, bringactivetotop," # only works on floating windows
        "$mod, P, exit" # exits compositor
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
      ];

      # Executes also while button is held down.
      binde = [
        ", XF86AudioMute, exec, amixer sset 'Master' toggle"
        # ", XF86AudioRaiseVolume, exec, amixer sset 'Master' 5%+"
        # ", XF86AudioRaiseVolume, exec, pactl -- set-sink-volume 0 +5%"
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        # ", XF86AudioLowerVolume, exec, amixer sset 'Master' 5%-"
        ", XF86AudioLowerVolume, exec, pactl -- set-sink-volume 0 -5%"
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      workspace = [
        "1, monitor:DVI-I-1, persistent:true, default:true"
        "2, monitor:DVI-I-1, persistent:true"
        "3, monitor:DVI-I-1, persistent:true"
        "4, monitor:HDMI-A-1, persistent:true, default:true"
        "5, monitor:HDMI-A-1, persistent:true"
        "6, monitor:HDMI-A-1, persistent:true"
      ];

      windowrulev2 = [
		    "float,class:(Bluetuith)"
		    "float,class:(nemo)"
        "float,size 627 287,class:(org.speedcrunch.)"
        ### Workspace 1
        "float,class:(discord)"
        "monitor DVI-I-1, class:(discord)"
        "workspace 1, class:(discord)"
        #
		    "float,class:(pavucontrol)"
        "monitor DVI-I-1, class:(pavucontrol)"
        "workspace 1, class:(pavucontrol)"
        #
        "float,class:(VirtualBox)"
        "monitor DVI-I-1, class:(VirtualBox)"
        "workspace 1, class:(VirtualBox)"
        ### Workspace 2
        "float,class:(code-url-handler)"
        "monitor DVI-I-1, class:(code-url-handler)"
        "workspace 2, class:(code-url-handler)"
        ### Workspace 3
        ### Workspace 4
        "monitor HDMI-A-1, class:(vivaldi)"
        "workspace 4, class:(vivaldi)"
        ### Workspace 5
		    "float,class:(.piper-wrapped)"
        "monitor HDMI-A-1, class:(.piper-wrapped)"
        "workspace 5, class:(.piper-wrapped)"
        #
		    "float,class:(solaar)"
        "monitor HDMI-A-1, class:(solaar)"
        "workspace 5, class:(solaar)"
	    ];

      # wsbind = [
      #   "1, DVI-I-1"
      #   "2, HDMI-A-1"
      #   # "3, DVI-I-1"
      #   # "4, HDMI-A-1"
      # ];

      exec-once = [
        "waybar"
        "hyprpaper"
        # "logid"
				#"hyprctl setcursor [THEME] [SIZE]"
        "solaar --window=hide"
				"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };
}

