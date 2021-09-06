#!/bin/bash

# stuff
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

# Brew installs
"$(brew --prefix)"/opt/fzf/install
brew cask install amethyst

# YouCompleteMe
git clone https://github.com/valloric/youcompleteme ~/.vim/bundle/youcompleteme
cd ~/.vim/bundle/youcompleteme || exit
git submodule update --init --recursive
~/.vim/bundle/youcompleteme/install.py --clangd-completer --go-completer --rust-completer

# not sure if this works so lets put this in the end
vim -c GoInstallBinaries -c exit

# some git config
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

# rust stuff
rustup component add rustfmt --toolchain stable-x86_64-apple-darwin
