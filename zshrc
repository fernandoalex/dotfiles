setopt prompt_subst

# import stuff
PLUGIN_FOLDER="$HOME/git/dotfiles/zsh-plugins"

FUNCTION_FILE="functions.zsh"
[ -f "$PLUGIN_FOLDER/$FUNCTION_FILE" ] && source $PLUGIN_FOLDER/$FUNCTION_FILE
ALIAS_FILE="alias.zsh"
[ -f "$PLUGIN_FOLDER/$ALIAS_FILE" ] && source $PLUGIN_FOLDER/$ALIAS_FILE

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin.local:/usr/local/bin:$PATH

# Git stuff
# Format the vcs_info_msg_0_ variable

# Enable colors and change prompt:
autoload -U colors && colors
PROMPT='
%B%{$fg[white]%}[ %{$fg[magenta]%}%(4~|.../%3~|%~)%{$fg[red]%}$(git_branch_name)%{$fg[blue]%}$(kubectl_profile)%{$fg[yellow]%}$(aws_profile)%{$fg[white]%} ] %{$reset_color%}
$%b '

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
bindkey '^j' vi-cmd-mode
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Custom Plugins
source ~/.zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh
source ~/.zsh/plugins/per-directory-history/per-directory-history.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export FZF_DEFAULT_COMMAND='rg --hidden ---glob !.git --files'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/git/inspec/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
