{ config, pkgs, lib, inputs, myLib, ... }:

{
  # Basic system configuration
  system.stateVersion = 4;
  
  # User configuration
  users.users.spanta = {
    name = "spanta";
    home = "/Users/spanta";
  };

  # Import macOS-specific modules
  imports = [
        ../../modules/darwin/homebrew.nix
        ../../modules/darwin/default.nix
  ];

  # Nix configuration
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "fernando" ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # Home Manager configuration
  home-manager.users.spanta = {
    imports = [ ../../modules/home ];
    
    # macOS-specific home settings
    targets.darwin.defaults = {
                    dock.autohide = true;
                    NSGlobalDomain._HIHideMenuBar = true;
                    spaces.spans-displays = true;
    };
  };
}
