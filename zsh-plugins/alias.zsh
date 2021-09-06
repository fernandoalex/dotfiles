alias r='cd $(git rev-parse --show-toplevel)'
alias co='git checkout `git branch -a | fzf | sed -e "s|remotes\/origin\/||"`'
alias grep='grep -i'
alias cat='bat'
alias ls='exa'
alias ll='exa -la --git'
alias vi='nvim'
alias "?"=duck
alias "wiki"=wiki_search
alias wt="worktree.sh"
alias date='date -u +"%Y-%m-%dT%H:%M:%S%Z"'
