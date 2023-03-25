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
    cargo
    rustc
    gcc
    cmake
    gnumake

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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
