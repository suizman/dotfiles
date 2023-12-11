#!/usr/bin/env bash

if [ ! -f ~/.config/fish/functions/_void.fish ];
then
  echo "Installing fish goodies."
  touch  ~/.config/fish/functions/_void.fish
  curl -L https://get.oh-my.fish | fish
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  omf install slavic-cat
  fish -c 'fisher install danhper/fish-ssh-agent'
  fish -c 'fisher install edc/bass'
  fish -c 'fisher install jorgebucaran/fish-bax'
  fish -c 'fisher install jorgebucaran/fish-spark'
  fish -c 'fisher install jethrokuan/z'
else
  echo "Fish goodies already installed."
fi

