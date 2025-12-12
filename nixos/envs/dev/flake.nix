{
  description = "Entorno global multi-Python (sin dream2nix)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # ── Versiones de Python que quieres disponibles globalmente ──
        pythonVersions = {
          py311 = pkgs.python311;
          py312 = pkgs.python312;
          py313 = pkgs.python313;
        };

        # Paquetes Python comunes a todos los entornos
        commonPythonPackages = ps: with ps; [
          colorama
          requests
          # añade aquí los que uses habitualmente
        ];

        makePythonEnv = python: python.withPackages commonPythonPackages;

        # ── Creación de los shells globales ─────────────────────────
        globalShells = builtins.mapAttrs (name: python:
          pkgs.mkShell {
            name = "global-${name}";
            buildInputs = with pkgs; [
              # Control de versiones
              git

              # Entorno Node.js (para herramientas JS/TS)
              nodejs_24

              # Entornos Python y tooling
              (makePythonEnv python)   # Python con paquetes comunes (colorama, requests...)
              poetry                   # Gestión de dependencias Python (pyproject)
              pipx                     # Ejecutar paquetes Python aislados
              uv                       # (tu herramienta 'uv' — p.ej. for uvicorn/cli si aplica)

              # Otras runtimes / lenguajes
              go

              # Descargas y red
              wget
              curl

              # Shells y experiencia del terminal
              fish
              zsh
              zoxide                   # Navegación de directorios rápida
              starship                 # Prompt moderno
              kitty.terminfo           # Soporte de terminfo para kitty

              # Monitorización y diagnóstico
              htop
              glances

              # Utilidades de archivos
              tree
              zip
              unzip
              dig                      # DNS lookup

              # Editores y utilidades de edición
              vim
              neovim
              nano
            ];

            shellHook = ''
              echo "Entorno global → Python ${python.version}"
              exec ${pkgs.fish}/bin/fish
            '';
          }
        ) pythonVersions;

      in
      {
        # Shells disponibles con `nix develop` o `nix develop .#py312` etc.
        devShells = globalShells // {
          default = globalShells.py313;   # `nix develop` sin argumentos usa este
        };
      });
}