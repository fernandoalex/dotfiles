{
  description = "cross-platform dotfiles - macOS, NixOS, and cloud";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    # Home Manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin for macOS
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional useful inputs
    flake-utils.url = "github:numtide/flake-utils";

    # Hardware-specific configurations for NixOS
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nix-darwin, nixos-hardware, flake-utils, ... }:
    let
      inherit (nixpkgs) lib;

      # Supported systems
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      # Helper function to generate packages for each system
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Custom lib functions
      myLib = import ./lib { inherit lib; };

      # Shared configuration between all machines
      sharedModules = [
        ./modules/common
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs myLib; };
        }
      ];

      # Overlays for all systems
      # overlays = [
      #   (import ./overlays)
      #   # Add more overlays here
      # ];

    in
    {
      # NixOS Configurations
      nixosConfigurations = {
        # Desktop/Laptop NixOS machine
        nixos-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs myLib; };
          modules = sharedModules ++ [
            ./hosts/nixos-laptop
            ./modules/nixos
            nixos-hardware.nixosModules.common-pc-ssd
            # agenix.nixosModules.default
            {
              # nixpkgs.overlays = overlays;
              home-manager.users.spanta = import ./modules/home;
            }
          ];
        };
      };

      # macOS Configurations (nix-darwin) - MOVED OUT of nixosConfigurations
      darwinConfigurations = {
        # Your MacBook
        darwin-laptop = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";  # or x86_64-darwin for Intel Macs
          specialArgs = { inherit inputs myLib; };
          modules = [
            ./hosts/darwin-laptop
            ./modules/darwin
            home-manager.darwinModules.home-manager
            # agenix.darwinModules.default
            {
              # nixpkgs.overlays = overlays;
              home-manager.users.spanta = import ./modules/home;
              home-manager.extraSpecialArgs = { inherit inputs myLib; };
            }
          ];
        };
      };

      # Development shells for each system - MOVED OUT of nixosConfigurations
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            # overlays = overlays;
          };
        in
        {
          default = pkgs.mkShell {
            name = "dotfiles-dev";
            packages = with pkgs; [
              nixfmt-classic
              nil  # Nix LSP
              git
              # age  # For agenix secrets
            ];
            shellHook = ''
              echo "Welcome to your dotfiles development environment!"
              echo "Available commands:"
              echo "  darwin-rebuild switch --flake .#darwin-laptop"
              echo "  nixos-rebuild switch --flake .#nixos-laptop"
            '';
          };
        });

      # # Custom packages - MOVED OUT of nixosConfigurations
      # packages = forAllSystems (system:
      #   let
      #     pkgs = import nixpkgs {
      #       inherit system;
      #       overlays = overlays;
      #     };
      #   in
      #   import ./packages { inherit pkgs; }
      # );

      # Overlays for external use - MOVED OUT of nixosConfigurations

      # Templates for new machines - MOVED OUT of nixosConfigurations
      # templates = {
      #   server = {
      #     path = ./templates/server;
      #     description = "Template for server configuration";
      #   };
      # };

      # Formatter for all systems - MOVED OUT of nixosConfigurations
      formatter = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.nixfmt-classic
      );
    };
}
