#!/usr/bin/env bash

if [ ! -d ~/.vim/colors ];
then
  echo "Installing Plug."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -c :PlugInstall +qall!
  echo "Updating Vim config."
  mkdir ~/.vim/colors
  ln -s ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim
else
  echo "Config already updated."
fi

