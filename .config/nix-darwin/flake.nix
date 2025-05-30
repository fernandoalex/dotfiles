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
                nixpkgs.config.allowUnfree = true;
                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                environment.systemPackages = [ 
                    pkgs.alacritty
                    pkgs.chafa
                    pkgs.ast-grep
                    pkgs.atuin
                    pkgs.awscli2
                    pkgs.bat
                    pkgs.btop
                    pkgs.cmake
                    pkgs.direnv
                    pkgs.dust
                    pkgs.eza
                    pkgs.fd
                    pkgs.fzf
                    pkgs.gcc
                    pkgs.cargo
                    pkgs.gh
                    pkgs.git
                    pkgs.git-lfs
                    pkgs.go
                    pkgs.irssi
                    pkgs.k9s
                    pkgs.kubectx
                    pkgs.kubernetes-helm
                    pkgs.lynx
                    pkgs.minikube
                    pkgs.moar
                    pkgs.neofetch
                    pkgs.neomutt
                    pkgs.neovim
                    pkgs.lua5_1
                    pkgs.luarocks
                    # language-servers
                    pkgs.lua-language-server
                    pkgs.eslint
                    pkgs.superhtml
                    pkgs.htmx-lsp
                    pkgs.nodejs
                    pkgs.parallel
                    pkgs.ripgrep
                    pkgs.starship
                    pkgs.stern
                    pkgs.stow
                    pkgs.tldr
                    pkgs.tmux
                    pkgs.zoxide
                    pkgs.ffmpeg
                    pkgs.exiftool
                    pkgs.yazi
                    pkgs.zig
                    pkgs.tt
                    pkgs.uv
                    # pkgs.lnav # broken on mac?
                    # pkgs.toot
                    # pkgs.pomodoro-cli # add to nix 
                    #github.com/open-pomodoro/openpomodoro-cli
                    # pkgs.mpv

                    (import ./utils/aws-s3-ls.nix {inherit pkgs;})
                    (import ./utils/aws-ebs-ls.nix {inherit pkgs;})
                    (import ./utils/aws-ec2-ls.nix {inherit pkgs;})
                    (import ./utils/aws-ec2-output.nix {inherit pkgs;})
                    (import ./utils/kubectl-get-nodes.nix {inherit pkgs;})
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
                    [ 
                        # pkgs.yabai
                    ];

                # Auto upgrade nix package and the daemon service.
                services.nix-daemon.enable = true;
                # The platform the configuration will be used on.
                nixpkgs.hostPlatform = "aarch64-darwin";
                system.stateVersion = 4;
                system.defaults = {
                    dock.autohide = true;
                    NSGlobalDomain._HIHideMenuBar = true;
                    spaces.spans-displays = true;
                };
                homebrew.enable = true;
                homebrew.casks = [
                    # "firefox"
                ];
                homebrew.brews = [
                    # "imagemagick"
                ];
            };

            nixosConfiguration = { pkgs, ... }: {
                # List packages installed in system profile. To search by name, run:
                # $ nix-env -qaP | grep wget
                environment.systemPackages =
                    [ pkgs.firefox ]; # firefox build is broken on macos
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
