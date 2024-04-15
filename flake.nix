{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let

    commonConfiguration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.ast-grep
            pkgs.lnav
            pkgs.atuin
            pkgs.btop
            pkgs.dust
            pkgs.stow
            pkgs.zoxide
            pkgs.fd
            pkgs.eza
            pkgs.ripgrep
            pkgs.neomutt
            pkgs.toot
            pkgs.lynx
            pkgs.irssi
            pkgs.awscli
            pkgs.neofetch
            pkgs.stow
            pkgs.neovim
            pkgs.tmux
            pkgs.git
            pkgs.alacritty
            pkgs.fzf
            pkgs.nerdfonts
            pkgs.starship
            pkgs.direnv
            (import ./utils/aws-s3-ls.nix {inherit pkgs;})
            (import ./utils/aws-ebs-ls.nix {inherit pkgs;})
            (import ./utils/aws-ec2-ls.nix {inherit pkgs;})
            (import ./utils/aws-ec2-output.nix {inherit pkgs;})
            (import ./utils/kubectl-get-nodes.nix {inherit pkgs;})

            # build stuff
            pkgs.gcc
            pkgs.cmake
        ];


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;

      system.configurationRevision = self.rev or self.dirtyRev or null;
    };

    macosConfiguration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.parallel
            pkgs.yabai
        ];

      services.yabai.enable = true;
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      system.stateVersion = 4;
    };

    nixosConfiguration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.firefox ];
    };

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#darwin
    darwinConfigurations."darwin" = nix-darwin.lib.darwinSystem {
      modules = [ 
      commonConfiguration
      macosConfiguration
      ];
    };

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      modules = [ 
      ./nixos/configuration.nix
      commonConfiguration
      nixosConfiguration
      ];
    };

    # # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."darwin".pkgs;
  };
}
