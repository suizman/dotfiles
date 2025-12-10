#!/usr/bin/env fish

set fisher_plugins "danhper/fish-ssh-agent edc/bass jorgebucaran/fish-bax jorgebucaran/fish-spark jethrokuan/z realiserad/fish-ai"

if not test -f ~/.config/fish/functions/_void.fish
  echo "Installing fish goodies."
  mkdir -p ~/.config/fish/functions
  touch ~/.config/fish/functions/_void.fish
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  for plugin in $fisher_plugins
    fish -c "fisher install $plugin"
  end
  curl -sS https://starship.rs/install.sh | sh
  echo "starship init fish | source" >> ~/.config/fish/config.fish 
else
  echo "Fish goodies already installed."
end

