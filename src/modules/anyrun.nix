{ pkgs, anyrun, ... }: {
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      #width = { fraction = 0.3; };
			#position = "top";
			closeOnClick = true;
			x = { fraction = 0.5; };
			y = { fraction = 0.5; };
			hidePluginInfo = true;
			maxEntries = null;
			showResultsImmediately = false;
			plugins = [
        anyrun.packages.x86_64-linux.applications
        anyrun.packages.x86_64-linux.rink
        anyrun.packages.x86_64-linux.kidex
        #anyrun.packages.x86_64-linux.websearch
			];
		};
		extraConfigFiles."applications.ron".text = ''
      Config(
			  // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from LibreWolf
				desktop_actions: true,
				max_entries: 5, 
				// The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
				// to determine what terminal to use.
				terminal: Some("alacritty"),
			)
		'';
		extraCss = ''
      /*  */
			#window {
			  /*background-color: #000000;*/
			  background-color: rgba(0,0,0,0.3);
				/*opacity: 0.8;*/
			}

			#entry {
				background-color: #2C2C2C;
				color: #ffffff;
				/*height: 40px;*/
				border-radius: 20px;
				border: 3px solid #ffffff;
			}

			#main {
				background-color: transparent;
			}

			#plugin {
				background-color: #2C2C2C;
			}
		'';
	};

	#home.file.".config/anyrun/style.css".text = ''
  #  /**/
	#'';

	#home.file.".config/anyrun/config.ron".text = ''
  #  //
	#'';
}
