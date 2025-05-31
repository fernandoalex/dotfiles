{ config, pkgs, lib, inputs, myLib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/nvidia.nix
  ];

  # System info
  networking.hostName = "nixos";
  
  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    
    # Gaming optimizations
    kernelParams = [
      "nvidia_drm.modeset=1"
      "vm.max_map_count=2147483642"  # For games like CS2
    ];
  };

  # User
  users.users.spanta = {
    isNormalUser = true;
    description = "spanta";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "gamemode" ];
    shell = pkgs.zsh;
  };

  # Desktop environment
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Network
  networking.networkmanager.enable = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
  ];

  # Enable zsh
  programs.zsh.enable = true;

  # Home Manager
  home-manager.users.spanta = {
    imports = [ ../../modules/home ../../modules/home/gaming.nix ];
  };

  system.stateVersion = "24.05";
}
