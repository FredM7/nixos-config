{ pkgs, hyprland, ... }: {
  wayland.windowManager.hyprland = {
  # imports = [
  #   hyprland.homeManagerModules.default
  # ];

  #programs.hyprland = {
    enable = true;

    #enableNvidiaPatches = true;
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
        "$mod, SPACE, exec, script-rofi"
        "$mod, C, killactive,"
        "$mod, T, togglefloating,"
        "$mod, S, swapnext,"
				"$mod, F, fullscreen, 0"
				"$mod, M, fullscreen, 1"
        "$mod, B, bringactivetotop," # only works on floating windows
        "$mod, P, exit" # exits compositor
        "SHIFT, Print, exec, kooha" # starts screen recorder
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
      ];

      # Executes also while button is held down.
      binde = [
        ", XF86AudioMute, exec, amixer sset 'Master' toggle"
        # ", XF86AudioRaiseVolume, exec, amixer sset 'Master' 5%+"
        # ", XF86AudioRaiseVolume, exec, pactl -- set-sink-volume 0 +5%"
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        # ", XF86AudioLowerVolume, exec, amixer sset 'Master' 5%-"
        ", XF86AudioLowerVolume, exec, pactl -- set-sink-volume 0 -5%"
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
        "4, monitor:DVI-I-1, persistent:true"
        "5, monitor:HDMI-A-1, persistent:true, default:true"
        "6, monitor:HDMI-A-1, persistent:true"
        "7, monitor:HDMI-A-1, persistent:true"
        "8, monitor:HDMI-A-1, persistent:true"
      ];

      windowrulev2 = [
        # By default, lets float all windows.
        "float, class:(.*)"
        # Set some floating window sizes
        "float,size 627 287,class:(org.speedcrunch.)"
        ### Workspace 1
        "monitor DVI-I-1, class:(discord)"
        "workspace 1, class:(discord)"
        #
        "monitor DVI-I-1, class:(pavucontrol)"
        "workspace 1, class:(pavucontrol)"
        #
        "monitor DVI-I-1, class:(VirtualBox)"
        "workspace 1, class:(VirtualBox)"
        ### Workspace 2
		    "tile, class:(code-url-handler)"
        "monitor DVI-I-1, class:(code-url-handler)"
        "workspace 2, class:(code-url-handler)"
        # ### Workspace 3
        # "float, class:(steam)"
        # # "tile, class:(steam)"
        # # "float, title:(Friends List)"
        # "monitor DVI-I-1, class:(steam)"
        # "workspace 3, class:(steam)"
        ### Workspace 5
		    "tile, class:(vivaldi)"
        "monitor HDMI-A-1, class:(vivaldi)"
        "workspace 5, class:(vivaldi)"
        ### Workspace 6
        "monitor HDMI-A-1, class:(.piper-wrapped)"
        # "workspace 6, class:(.piper-wrapped)"
        ##
        "float, class:(steam)"
        # "tile, class:(steam)"
        # "float, title:(Friends List)"
        "monitor HDMI-A-1, class:(steam)"
        #
        "monitor HDMI-A-1, class:(solaar)"
        "workspace 6, class:(solaar|steam|.piper-wrapped)"
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

