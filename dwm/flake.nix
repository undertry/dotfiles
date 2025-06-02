{
  description = "Dev shell for dwm";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        xorg.libX11
        xorg.libXinerama
        xorg.libXft
        pkg-config
        gnumake
        gcc
        wget
      ];
    };
  };
}

