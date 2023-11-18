{ pkgs, inputs, ... }:{
  programs.vscode = {
		# Look in config configuration.nix, environment.sessionVariables.
		# There, we define something special, RUST_SRC_PATH.
    enable = true;
		# package = inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium;
		# package = (import inputs.nixpkgs-vscode {
  #     system = pkgs.system;
  #     config.allowUnfree = true;
  #   }).vscode.overrideAttrs (o: {});
		extensions = with pkgs.vscode-extensions; [
      # rust-analyzer
			github.copilot
		];
  };

	# home.file.".vscode-oss/argv.json" = {
	home.file.".vscode/argv.json" = {
    force = true;
    text = ''
      {
      	// "disable-hardware-acceleration": true,
      	"enable-crash-reporter": true,
      	// Unique id used for correlating crash reports sent from this instance.
      	// Do not edit this value.
      	// "crash-reporter-id": "3e70c403-3a28-45e0-b63c-ea5bb89a2ed6",
        "crash-reporter-id": "90fd0e0b-eb72-494d-8572-48fb4c4b3965",
        "password-store": "gnome"
      }
    '';
  };
}
