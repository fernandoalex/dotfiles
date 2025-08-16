{ config, pkgs, lib, ... }:

{
  # Homebrew configuration for macOS-specific apps

  system.primaryUser = "spanta";
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
    # Taps
    taps = [
    ];
    
    # Brews (CLI tools not available in nixpkgs or work better via Homebrew)
    brews = [
      "mas"  # Mac App Store CLI
    ];
    
    # Casks (GUI applications)
    casks = [
      "firefox"
      "1password"
      "ghostty"
    ];
    
    # Mac App Store apps
    masApps = {
      "Xcode" = 497799835;
    };
  };
}
