{ pkgs, inputs, ... }:{
  programs.vscode = {
		# Look in config configuration.nix, environment.sessionVariables.
		# There, we define something special, RUST_SRC_PATH.
    enable = true;
		# package = inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium;
		extensions = with pkgs.vscode-extensions; [
      # If the extensions is not taking effect, try to
      # remove ~/.vscode/extensions/extensions.json, or even 
      # the whole directory ~/.vscode/extensions.
      bbenoist.nix
      rust-lang.rust-analyzer
      github.copilot
      github.copilot-chat
      golang.go
      dart-code.dart-code
      dart-code.flutter
      bradlc.vscode-tailwindcss
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
