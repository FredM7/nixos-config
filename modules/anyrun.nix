{ ... }: {
  programs.anyrun = {
    enable = true;
		config = {
      width = { fraction = 0.3; };
			position = "top";
		};
		extraCss = ''
      /*  */
		'';
	};
}
