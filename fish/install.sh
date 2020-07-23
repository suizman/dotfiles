#!/usr/bin/env bash

if [ ! -f ~/.config/fish/functions/_void.fish ];
then
  echo "Installing fish goodies."
  touch  ~/.config/fish/functions/_void.fish
  curl -L https://get.oh-my.fish | fish
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fish -c 'fisher add danhper/fish-ssh-agent'
  fish -c 'fisher add edc/bass'
  fish -c 'fisher add jorgebucaran/fish-bax'
  fish -c 'fisher add jorgebucaran/fish-spark'
  fish -c 'fisher add jethrokuan/z'
else
  echo "Fish goodies already installed."
fi

