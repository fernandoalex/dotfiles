# TODOs:
# - NVIDIA Cuda stuff
{ config, pkgs, ... }:

{
  home.username = "spanta";
  home.homeDirectory = "/home/spanta";

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neovim
    tmux
    fzf
    fd
    ripgrep
    bat
    go
    nodejs
    unzip
    rustup
    systemd
    gcc
    pkg-config
    udev
    udev.dev
    cmake
    gnumake
    alsaLib
    alsaLib.dev
    starship
  ];

  xdg.configFile.nvim = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/spanta/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${config.home.profileDirectory}/lib/pkgconfig";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.starship.enable = true;
  programs.starship.settings = {
	  add_newline = false;
	  format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration\n$character";
	  shlvl = {
		  disabled = false;
		  symbol = "ﰬ";
		  style = "bright-red bold";
	  };
	  shell = {
		  disabled = false;
		  format = "$indicator";
		  fish_indicator = "";
		  bash_indicator = "[BASH](bright-white) ";
		  zsh_indicator = "[ZSH](bright-white) ";
	  };
	  username = {
		  style_user = "bright-white bold";
		  style_root = "bright-red bold";
	  };
  };
}
