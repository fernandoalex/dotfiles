#!/bin/bash

#zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# clonning repos
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# links
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc

# VIM Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Brew installs
brew install tmux
brew install fzf
brew install tldr
brew install ccat
brew install cmake 
brew install macvim
$(brew --prefix)/opt/fzf/install

# Pathogen plugins
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
git clone https://github.com/altercation/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/kien/ctrlp.vim ~/.vim/bundle/ctrlp

# YouCompleteMe
git clone https://github.com/valloric/youcompleteme ~/.vim/bundle/youcompleteme
cd ~/.vim/bundle/youcompleteme
git submodule update --init --recursive
~/.vim/bundle/youcompleteme/install.py --clangd-completer --go-completer --rust-completer
