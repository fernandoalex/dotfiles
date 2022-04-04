#!/bin/bash

# Brew installs
"$(brew --prefix)"/opt/fzf/install
brew cask install amethyst

# not sure if this works so lets put this in the end
vim -c GoInstallBinaries -c exit

# some git config
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
