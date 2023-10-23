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
			plugins = [
        anyrun.packages.x86_64-linux.applications
        #anyrun.packages.x86_64-linux.websearch
			];
		};
		extraCss = ''
      /*  */
			#window {
			  /*background-color: #000000;*/
			  background-color: rgba(0,0,0,0.3);
				/*opacity: 0.8;*/
			}

			#entry {
				background-color: #2C2C2C;
				color: #000000;
				/*height: 40px;*/
				border-radius: 20px;
				border: 3px solid #ffffff;
			}

			#main {
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
