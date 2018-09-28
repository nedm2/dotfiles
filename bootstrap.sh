#!/bin/bash

cd $HOME
git clone https://github.com/nedm2/dotfiles.git .dotfiles
.dotfiles/install.py

touch $HOME/.z

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -c ":PluginInstall" -c ":qall"
