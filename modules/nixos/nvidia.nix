{ config, pkgs, lib, ... }:

{
  # General NVIDIA configuration that works across different hardware
  
  # Enable unfree packages (needed for NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;
  
  # Blacklist nouveau driver
  boot.blacklistedKernelModules = [ "nouveau" ];
  
  # Load NVIDIA modules early
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  
  # General gaming optimizations
  boot.kernelParams = [
    "nvidia_drm.modeset=1"
    "nvidia_drm.fbdev=1"
  ];
  
  # General environment variables for NVIDIA
  environment.variables = {
    # Shader cache optimizations
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };
  
  # Ensure 32-bit support for gaming
  hardware.opengl.driSupport32Bit = lib.mkDefault true;
  hardware.pulseaudio.support32Bit = lib.mkDefault true;
}
