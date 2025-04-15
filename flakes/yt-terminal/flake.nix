{
  description = "Environment for yewtube with mpv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          packages = with pkgs; [
            mpv
            (python3.withPackages (ps: with ps; [ pip yt-dlp ]))
          ];

          shellHook = ''
            echo "🌀 Activando entorno virtual para yewtube..."

            if [ ! -d "env" ]; then
              python3 -m venv env
              pip install git+https://github.com/mps-youtube/yewtube.git
              source env/bin/activate
            else
              source env/bin/activate
            fi

            echo "✅ yewtube listo. Escribí 'yt' para empezar."
          '';
        };
      });
}

