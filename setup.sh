#!/bin/bash

#zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p .zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions

# clonning repos
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# stuff
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

mkdir ~/.vimdid

# VIM Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Brew installs
brew install tmux
brew install fzf
brew install tldr
brew install ccat
brew install cmake 
brew install macvim
brew install exa
brew install rg
$(brew --prefix)/opt/fzf/install
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install w3m
brew install shellcheck
brew install ctags

# Pathogen plugins
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
git clone https://github.com/altercation/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/kien/ctrlp.vim ~/.vim/bundle/ctrlp
git clone https://github.com/hashivim/vim-terraform.git ~/.vim/bundle/vim-terraform
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone https://github.com/junegunn/fzf.vim.git ~/.vim/bundle/fzf
git clone https://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround
git clone https://github.com/tpope/vim-repeat.git ~/.vim/bundle/vim-repeat
git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/bundle/vim-gutentags
git clone https://github.com/cespare/vim-toml.git ~/.vim/bundle/vim-toml

# YouCompleteMe
git clone https://github.com/valloric/youcompleteme ~/.vim/bundle/youcompleteme
cd ~/.vim/bundle/youcompleteme
git submodule update --init --recursive
~/.vim/bundle/youcompleteme/install.py --clangd-completer --go-completer --rust-completer

source ~/.zshrc
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# not sure if this works so lets put this in the end
vim -c GoInstallBinaries -c exit

# some git config
git config --global core.excludesfile ~/.gitignore_global
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

# rust stuff
rustup component add rustfmt --toolchain stable-x86_64-apple-darwin
