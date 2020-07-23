#!/usr/bin/env bash

if [ ! -d ~/.vim/colors ];
then
  echo "Installing Plug."
  curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  cp vim/.vimrc ~/.vimrc
  mkdir -p ~/.vim/colors
  yes | vim +PlugInstall +qall &>/dev/null
  ln -s ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim
else
  echo "Config already updated."
fi

