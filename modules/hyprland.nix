{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    settings = {
		  # https://wiki.hyprland.org/Configuring/Variables/

      monitor= [
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
        "$mod, B, bringactivetotop," # only works on floating windows
        "$mod, X, exit" # exits compositor
      ];

      # Executes also while button is held down.
      binde = [
        ", XF86AudioMute, exec, amixer sset 'Master' toggle"
        ", XF86AudioRaiseVolume, exec, amixer sset 'Master' 5%+"
        ", XF86AudioLowerVolume, exec, amixer sset 'Master' 5%-"
        ", Print, exec, shotman -c region"
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
	    ];

      exec-once = [
        "waybar"
        "hyprpaper"
				#"hyprctl setcursor [THEME] [SIZE]"
      ];
    };
  };
}

