
{
  description = "Nixos flake to make remote connections";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.getmac.url = "github:InterMW/mac-flake";

  outputs = { self, nixpkgs , getmac}:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}= 
	{
		default = pkgs.writeShellApplication {
        name = "getport";
        runtimeInputs = [ pkgs.autossh ];
        text = ''
          #!${pkgs.stdenv.shell}
          ${builtins.readFile ./getport.sh}
        '';
        checkPhase = "${pkgs.stdenv.shellDryRun} $target";
      	};

      other  = pkgs.writeShellApplication {
        name = "say_fooo";
        runtimeInputs = [ pkgs.autossh ];
        text = ''
          #!${pkgs.stdenv.shell}
          ${builtins.readFile ./script.sh}
        '';
        checkPhase = "${pkgs.stdenv.shellDryRun} $target";
	}; 
      };
    };
}

