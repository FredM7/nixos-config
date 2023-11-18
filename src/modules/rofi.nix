{ pkgs, ... }: {
  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      // modes: [ combi ];
			// combi-modes: [ window, drun, run ];

		}

    //@theme "/nix/store/vb9x7z84xw5pqbkgbs70bdbji3wg5yy3-rofi-1.7.5+wayland2/share/rofi/themes/Monokai.rasi"
    @theme "/nix/store/vb9x7z84xw5pqbkgbs70bdbji3wg5yy3-rofi-1.7.5+wayland2/share/rofi/themes/gruvbox-dark-hard.rasi"

		entry {
      placeholder: "Type here..";
      cursor: pointer;
			background-color: #ff0000;
			text-color: black;
			// cursor-color: rgb(0, 0, 255);
      // cursor-width:  dont kno8px;
		}

		element {
      orientation: horizontal;
			children: [ element-icon, element-text ];
			spacing: 5px;
		}

		element-icon {
      size: 20px;
		}

		element-text {
      vertical-align: 0.5;
		}
  '';
}
