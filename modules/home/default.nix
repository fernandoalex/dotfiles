{ config, pkgs, lib, ... }:

{
  # 🎯 This is the critical line that was missing or not working
  home.stateVersion = "24.05";
  
  # Basic home configuration
  home.username = "spanta";

  # Common packages
  home.packages = with pkgs; [
        git
        git-lfs
        neovim
        curl
        tree
        htop
        atuin
        eza
        bat
        fd
        ripgrep
        jq
        fzf
        tmuxinator
        tt
        uv
        btop
        yazi
        skim
        fastfetch
        pass
        irssi

        kitty # to enable kitty icat

        #LSP/Dev Stuff
        gopls
        eslint
        htmx-lsp
        lua-language-server
        cargo
        python3

        # NodeJS
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Fernando Alex";
    userEmail = "jfernandoalex@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "upstream";
    };
  };

  programs.ghostty.settings = {
    theme = "tokyo-night";        # Recommended for developers
         font-size = 23;
  };

    imports = [
        ./shell.nix
    ];

  # 📚 Atuin - Better shell history
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Sync settings (optional - requires atuin account)
      auto_sync = false;  # Set to true if you want cloud sync
      sync_frequency = "1h";
      
      # Search settings
      search_mode = "fuzzy";
      filter_mode = "global";
      show_preview = true;
      max_preview_height = 4;
      
      # History settings
      update_snapshots = true;
      history_filter = [
        "^secret-tool"
        "^adb.*backup"
      ];
      
      # UI settings
      style = "compact";
      inline_height = 20;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;  # Better Nix support
    
    config = {
      # Global direnv settings
      global = {
        warn_timeout = "1m";
        hide_env_diff = true;
      };
    };
  };

  programs.tmux = {
    enable = true;
    
    # Basic settings from your config
    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 5;
    historyLimit = 5000;
    keyMode = "vi";
    mouse = true;
    terminal = "xterm-ghostty";
    
    # Custom prefix (your C-a instead of C-b)
    prefix = "C-a";
    
    # Shell integration
    shell = "${pkgs.zsh}/bin/zsh";
    
    # All your custom configuration
    extraConfig = ''
      tmux_conf_copy_to_os_clipboard=true
      
      # General settings
      set-option -g detach-on-destroy off
      setw -g xterm-keys on
      set -sg repeat-time 600
      set -s focus-events on
      
      # Unbind default t
      unbind t
      
      # Window navigation with Shift+arrows
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      
      # UTF-8 support
      set -q -g status-utf8 on
      setw -q -g utf8 on
      
      # Display settings
      setw -g pane-base-index 1
      setw -g automatic-rename on
      set -g renumber-windows on
      
      # Custom window status format
      set -g window-status-format '#I:#(pwd="#{pane_current_path}"; echo ''${pwd####*/})#F '
      set -g window-status-current-format '#I:#(pwd="#{pane_current_path}"; echo ''${pwd####*/})#F '
      
      # Terminal title
      set -g set-titles on
      
      # Display timing
      set -g display-panes-time 800
      set -g display-time 1000
      set -g status-interval 10
      
      # Clear screen (modified for compatibility)
      bind -n C-l send-keys C-l \; run 'sleep 0.1'
      
      # Activity monitoring
      set -g monitor-activity on
      set -g visual-activity off
      
      # Session management
      bind C-c new-session
      bind C-f command-prompt -p find-session 'switch-client -t %%'
      
      # Pane splitting (your custom bindings)
      bind - split-window -vb -c "#{pane_current_path}"
      bind _ split-window -hb -c "#{pane_current_path}"
      
      # Pane navigation (vi-like)
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      
      # Pane resizing
      bind -r C-h resize-pane -L 2
      bind -r C-j resize-pane -D 2
      bind -r C-k resize-pane -U 2
      bind -r C-l resize-pane -R 2
      
      # Window navigation
      unbind n
      unbind p
      
      # Copy mode
      bind Enter copy-mode
      
      # Vi-copy bindings (compatible with modern tmux)
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line
      
      # macOS clipboard integration (improved)
      if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
      
      bind-key -r i run-shell "~/bin/tmux-jump.sh"
      # Status bar styling
      # Tokyo Night theme (alternative to Gruvbox)
      set -g status-justify "left"
      set -g status "on"
      set -g status-left-style "none"
      set -g message-command-style "fg=#c0caf5,bg=#414868"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=#7aa2f7"
      set -g status-style "none,bg=#24283b"
      set -g message-style "fg=#c0caf5,bg=#414868"
      set -g pane-border-style "fg=#414868"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "none"
      setw -g window-status-separator ""
      setw -g window-status-style "none,fg=#c0caf5,bg=#24283b"
      
      set -g status-left "#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#24283b,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#414868,bg=#24283b,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#414868] %Y-%m-%d #[fg=#15161e,bg=#7aa2f7,bold] %H:%M"
      setw -g window-status-format "#[fg=#c0caf5,bg=#24283b] #I #[fg=#c0caf5,bg=#24283b] #W "
      setw -g window-status-current-format "#[fg=#24283b,bg=#414868,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#414868] #I #[fg=#c0caf5,bg=#414868] #W #[fg=#414868,bg=#24283b,nobold,nounderscore,noitalics]"

      # Better integration with Ghostty + Starship + Atuin
      
      # True color support for Ghostty
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      
      # Allow passthrough for modern terminal features
      set -g allow-passthrough on
      
      # Better shell integration
      set -g default-command "${pkgs.zsh}/bin/zsh"
      
      # Ensure environment variables are passed through
      set -ga update-environment " STARSHIP_SHELL"
      set -ga update-environment " ATUIN_SESSION"
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
      # Don't interfere with shell history (Atuin handles this)

      set -g history-file ""
      
      # Better window titles for your workflow
      set -g set-titles-string "#T - #W"
      
      # Faster escape for vim users
      set -sg escape-time 1
      
      # Start windows and panes at 1, not 0 (easier to reach)
      set -g base-index 1
      setw -g pane-base-index 1
    '';
    
    plugins = with pkgs.tmuxPlugins; [
      # Essential plugins
      sensible          # Sensible defaults
      yank             # Better copy/paste
      # Session management
      resurrect        # Save/restore sessions
      continuum        # Automatic saving
      # Navigation
      pain-control     # Better pane navigation
    ];
  };

  # Create tmux session configurations with tmuxinator
  # This replaces the need for manual session setup
  home.file.".tmuxinator/dev.yml".text = ''
    name: dev
    root: ~/projects
    
    windows:
      - editor: vim
      - server: 
      - logs: tail -f logs/development.log
  '';
}
