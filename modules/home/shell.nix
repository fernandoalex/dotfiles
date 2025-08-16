{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };   
    shellAliases = {
      ll = "eza -la";
    tree = "eza --tree";
      grep = "grep --color=auto";
            
    };
    # Additional shell options
    initContent = ''
      # Better history search
      bindkey '^R' history-incremental-search-backward
      bindkey -s '^f' '~/bin/tmux-jump.sh^M'
      
      # Edit command line in editor
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line
      
      # Case insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      
      # Better completion menu
      zstyle ':completion:*' menu select
      
      # Colored completion
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    '';
  };

programs.starship = {
    enable = true;
    settings = {
      # Custom prompt format
      format = "$all$character";
      
      # Prompt character
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      
      # Directory display
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold blue";
      };
      
      # Git integration
      git_branch = {
        style = "bold purple";
      };
      
      git_status = {
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        up_to_date = "✓";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "➕";
        renamed = "👅";
        deleted = "🗑";
      };
      
      # Language/tool indicators
      nodejs = {
        symbol = " ";
        style = "bold green";
      };
      
      python = {
        symbol = " ";
        style = "bold yellow";
      };
      
      rust = {
        symbol = " ";
        style = "bold red";
      };
      
      # Docker
      docker_context = {
        symbol = " ";
        style = "bold blue";
      };
      
      # Nix shell indicator
      nix_shell = {
        symbol = " ";
        style = "bold blue";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };
      
      # Command duration
      cmd_duration = {
        min_time = 2000;
        format = "took [$duration](bold yellow)";
      };
      
      # AWS
      aws = {
        style = "bold orange";
        symbol = "  ";
      };
    };
  };
}
