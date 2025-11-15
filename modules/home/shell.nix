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

      # FastFetch
      fastfetch
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

    # Setting Ghostty from Nix is a bit meh at the moment
    # programs.ghostty = {
    #     enable = true;
    #     package = null;  # Set to null since it's not installed via Nix on macOS
    #
    #     # Settings map directly to Ghostty's config keys (key-value pairs).
    #     # See https://ghostty.org/docs/config for all available options.
    #     settings = {
    #         font-family = "CommitMonoAutomata";
    #         font-size = 14;
    #         font-thicken = false;
    #         macos-titlebar-style = "hidden";
    #         window-decoration = true;
    #         background-opacity = 0.98;
    #         background-blur-radius = 0;
    #         unfocused-split-opacity = 0.30;
    #         window-padding-x = "2,2";
    #         window-padding-y = "2,2";
    #         cursor-style = "block_hollow";
    #         macos-icon = "custom-style";
    #         macos-icon-frame = "plastic";
    #         macos-icon-ghost-color = "#DFEBF5";
    #         macos-icon-screen-color = "#74B0CF";
    #         # background = "EBE6D2";
    #         # foreground = "2B2A2A";
    #
    #         # palette = [
    #         #     "0=#2B2A2A"
    #         #     "8=#402F27"
    #         #     "1=#662A37"
    #         #     "9=#992C34"
    #         #     "2=#244E33"
    #         #     "10=#416647"  # Added # for consistency, as it was missing in the original (likely a typo)
    #         #     "3=#B67F21"
    #         #     "11=#ADAD39"
    #         #     "4=#3A4A67"
    #         #     "12=#5B89A7"
    #         #     "5=#674C8B"
    #         #     "13=#954C5F"
    #         #     "6=#457A7A"
    #         #     "14=#328E8F"
    #         #     "7=#C0BCAC"
    #         #     "15=#EBE6D2"
    #         # ];
    #     };
    # };
}
