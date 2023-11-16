{ pkgs, inputs, ... }:{
  programs.vscode = {
    enable = true;
		# package = inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium.fhsWithPackages (ps: with ps; [ rustup rust-analyzer ]);
		# package = pkgs.vscode.fhs;
		# package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup rust-analyzer ]);
		package = inputs.nixpkgs-vscodium.legacyPackages.${pkgs.system}.vscodium;
		extensions = with pkgs.vscode-extensions; [
      # rust-analyzer
		];
  };
}
