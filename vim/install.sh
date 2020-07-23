#!/usr/bin/env bash

if [[ $(which node | wc -l) -eq 0 ]];
then
  echo "Nodejs missing, please install it. It's required for Coc plugin"
  exit 1
fi

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

