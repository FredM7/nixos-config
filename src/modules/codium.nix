{ pkgs, inputs, ... }:{
  # codium = inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium;

  programs.vscode = {
		# Look in config configuration.nix, environment.sessionVariables.
		# There, we define something special, RUST_SRC_PATH.
    enable = true;

    enableUpdateCheck = false; # Stop bothering me about updates.
    
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.inlineSuggest.enabled" = true;
      "vsicons.dontShowNewVersionMessage" = true;
      "workbench.iconTheme" = "vscode-icons";
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace, 'EnvyCodeR Nerd Font'";
    };
    
    # userTasks = [
    #   {
    #     label = "Setup Nix Dev Environment";
    #     type = "shell";
    #     command = "cd ~/Documents/nixos-config && nix-shell --command fish";
    #     # args = [ "build" ];
    #     problemMatcher = [];
    #     runOptions = {
    #       runOn = "folderOpen";
    #     };
    #   }
    # ];

		extensions = with pkgs.vscode-extensions; [
      # If the extensions is not taking effect, try to
      # remove ~/.vscode/extensions/extensions.json, or even 
      # the whole directory ~/.vscode/extensions.
      vscode-icons-team.vscode-icons
      eamodio.gitlens
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
