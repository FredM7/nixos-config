{ pkgs, ... }: {
  #programs.anyrun = {
  #  enable = true;
  #  config = {
  #    width = { fraction = 0.3; };
	#		position = "top";
	#	};
	#	extraCss = ''
  #    /*  */
	#	'';
	#};

	home.file.".config/anyrun/style.css".text = ''
    /**/
	'';

	home.file.".config/anyrun/config.ron".text = ''
    //
	'';
}
