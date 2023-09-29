alias r='cd $(git rev-parse --show-toplevel)'
alias co='git checkout `git branch -a | fzf | sed -e "s|remotes\/origin\/||"`'
alias grep='grep -i'
alias cat='bat'
alias ls='eza'
alias ll='eza -la --git --icons'
alias date='date -u +"%Y-%m-%dT%H:%M:%S%Z"'
alias tfuse='tfenv use `tfenv list | fzf`'

# kubernetes stuff
alias set-ns='k8s-set-ns.sh'

alias k='kubectl'
alias g='git'
alias gw='git-worktree-add.sh'
alias n='nvim'
