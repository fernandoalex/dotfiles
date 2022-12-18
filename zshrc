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
export VISUAL=vi
export EDITOR="$VISUAL"
export HISTFILE=~/.zsh_history
# Git stuff
# Format the vcs_info_msg_0_ variable

# Enable colors and change prompt:
autoload -U colors && colors
# PROMPT='
# %B%{$fg[white]%}[ %{$fg[magenta]%}%(4~|.../%3~|%~)%{$fg[red]%}$(git_branch_name)%{$fg[blue]%}$(kubectl_profile)%{$fg[green]%}$(kubectl_namespace)%{$fg[yellow]%}$(aws_profile)%{$fg[white]%} ] %{$reset_color%}
# $%b '

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
setopt nocasematch
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
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export FZF_DEFAULT_COMMAND='rg --hidden ---glob !.git --files'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/git/inspec/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/brew/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

bindkey -s '^f' 'tmux-jump.sh^M' 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source "/usr/local/opt/spaceship/spaceship.zsh"
# export SPACESHIP_PROMPT_ASYNC=false
eval "$(starship init zsh)"
