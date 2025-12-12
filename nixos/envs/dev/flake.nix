{
  description = "Developement Flake for Nix";

  # Use the latest stable Nixpkgs (as of Dec 2025)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Development shell: run with `nix develop`
        devShells.default = pkgs.mkShell {
          name = "dev-nix";

          # Packages available in the shell
          buildInputs = with pkgs; [
            # Programming
            git
            nodejs_24
            python314
            # python314Packages.pip
            # python314Packages.virtualenv
            go

            # Web tools
            wget

            # Shell
            fish
            zsh
            # Directory jumper: prefer zoxide over older `z` implementations
            zoxide
            starship

            # Terminals
            kitty

            # System
            dig
            glances
            htop
            tree
            zip

            # Editors
            vim
            nano
          ];

          # Configure fish as default shell
          shellHook = ''
            # Forzamos que nix develop use fish
            exec ${pkgs.fish}/bin/fish
          '';
        };

        # Optional: you can also expose packages, apps, etc.
        packages.hello = pkgs.hello;

        apps.hello = flake-utils.lib.mkApp { drv = pkgs.hello; };
      });
}
