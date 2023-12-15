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
        rounding = 4;
        #inactive_opacity = 0.8;
        drop_shadow = true;
        dim_inactive = true;
        dim_strength = 0.2;
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

      windowrulev2 = [
        # "float,class:(.blueman-manager-wrapped)" # Find class names by terminal: 'hyprctl clients'
		    "float,class:(Bluetuith)"
		    #"float,class:(org.kde.krusader)"
        "float,size 627 287,class:(org.speedcrunch.)"
		    "float,class:(pavucontrol)"
		    "float,class:(solaar)"
        "float,class:(VirtualBox)"
        # Workspace 1
        "float,class:(discord)"
        "monitor DVI-I-1, class:(discord)"
        "workspace 1, class:(discord)"
        # Workspace 2
        "monitor HDMI-A-1, class:(vivaldi)"
        "workspace 2, class:(vivaldi)"
        # Workspace 3
        "float,class:(code-url-handler)"
        "monitor DVI-I-1, class:(code-url-handler)"
        "workspace 3, class:(code-url-handler)"
        # Workspace 4
		    "float,class:(.piper-wrapped)"
        "monitor HDMI-A-1, class:(.piper-wrapped)"
        "workspace 4, class:(.piper-wrapped)"
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

