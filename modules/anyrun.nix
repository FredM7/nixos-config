{ pkgs, anyrun, ... }: {
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      #width = { fraction = 0.3; };
			#position = "top";
			plugins = [];
		};
		extraCss = ''
      /*  */
		'';
	};

	#home.file.".config/anyrun/style.css".text = ''
  #  /**/
	#'';

	#home.file.".config/anyrun/config.ron".text = ''
  #  //
	#'';
}
