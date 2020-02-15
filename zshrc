# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
#  aws           # Amazon Web Services section
  venv          # virtualenv section
  pyenv         # Pyenv section
#  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_CHAR_SYMBOL='$'
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_TIME_SHOW=true
SPACESHIP_HG_SHOW=false
SPACESHIP_HG_BRANCH_SHOW=false
SPACESHIP_HG_STATUS_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_HASKELL_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_BATTERY_SHOW=false

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

alias r='cd $(git rev-parse --show-toplevel)'
alias co='git checkout `git branch -a | fzf | sed -e "s|remotes\/origin\/||"`'
alias grep='grep -i'
alias cat='ccat'
alias ls='exa'
alias ll='exa -la --git'
alias note='vim `date -u +"%Y-%m-%d"`'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/git/inspec/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v
bindkey '^j' vi-cmd-mode

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

alias v="code"
alias r='cd $(git rev-parse --show-toplevel)'
alias co='git checkout `git branch -a | fzf | sed -e "s|remotes\/origin\/||"`'
alias grep='grep -i'
alias cat='ccat'
alias ls='exa'
alias ll='exa -la --git'

if [[ -f ~/.fzf.zsh ]]; then 
	source ~/.fzf.zsh
fi

if [[ -e ~/.zshrc.local ]]; then
	source ~/.zshrc.local
fi
