=======
# TODOs:
# - NVIDIA Cuda stuff
# - to config with nix:
# - - zsh: setup not working properly
{ config, pkgs, ... }:

{
  home.username = "spanta";
  home.homeDirectory = "/home/spanta";

  home.stateVersion = "22.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    alsaLib
    alsaLib.dev
    awscli
    bat
    cmake
    direnv
    exa
    fd
    firefox
    fzf
    gcc
    gh
    gnumake
    go
    lynx
    neomutt
    neovim
    nodejs
    pkg-config
    ripgrep
    rustup
    starship
    systemd
    tmux
    udev
    udev.dev
    unzip
    zoxide
    zsh
    zstd
  ];

  xdg.configFile.nvim = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };


  home.sessionVariables = {
	  EDITOR = "nvim";
	  PKG_CONFIG_PATH = "${config.home.profileDirectory}/lib/pkgconfig";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.tmux = {
	enable = true;
	shortcut = "a";
	extraConfig = ''
		set -g default-terminal "xterm-256color"
		set -ga terminal-overrides ",*256col*:Tc"
		set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
		set-environment -g COLORTERM "truecolor"

		bind _ split-window -h -c "#{pane_current_path}"
		bind - split-window -v -c "#{pane_current_path}"
		bind c new-window -c "#{pane_current_path}"
    '';

  };

  programs.zsh = {
	enable = true;
	initExtra = ''
		eval "$(zoxide init zsh)"
	'';
  };
  

  # starship stuff
  programs.starship.enable = true;
  programs.starship.settings = {
	  add_newline = false;
	  format = 
	  "$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration\n$character";
	  shell = {
		  disabled = false;
		  format = "$indicator";
	  };
	  username = {
		  style_user = "bright-white bold";
		  style_root = "bright-red bold";
	  };
  };
}
