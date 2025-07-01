
{
  description = "Nixos flake to make remote connections";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.getmac.url = "github:InterMW/mac-flake";

  outputs = { self, nixpkgs , getmac}:
    let
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";
      version = builtins.substring 0 8 lastModifiedDate;
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });
    in
    {
      # A Nixpkgs overlay.
      overlay = final: prev: {

        remoteconnect = with final; stdenv.mkDerivation rec {
          name = "remoteconnect-${version}";

          unpackPhase = ":";

          buildPhase =
            ''
              cat > remoteconnect <<EOF
              #! $SHELL
	      ${builtins.readFile ./script.sh}
              EOF
              chmod +x getmac
            '';

          installPhase =
            ''
              mkdir -p $out/bin
              cp remoteconnect $out/bin/
            '';
        };

      };
      defaultPackage = forAllSystems (system: self.packages.${system}.getmac);
      # Provide some binary packages for selected system types.
      packages = forAllSystems (system:
        {
          inherit (nixpkgsFor.${system}) remoteconnect;
        });
    };
      nixosModules.remoteconnect =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlay ];

          environment.systemPackages = [ pkgs.remoteconnect ];

          #systemd.services = { ... };
        };
}

