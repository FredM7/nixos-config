{ ... } : {
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
    ", XF86AudioRaiseVolume, exec, amixer sset 'Master' 5%+"
    ", XF86AudioLowerVolume, exec, amixer sset 'Master' 5%-"
    ", Print, exec, shotman -c region"
  ];

  bindm = [
    # mouse movements
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
}
