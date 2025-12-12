#!/usr/bin/env fish

set fisher_plugins "danhper/fish-ssh-agent edc/bass jorgebucaran/fish-bax jorgebucaran/fish-spark realiserad/fish-ai"

if not test -f ~/.config/fish/functions/_void.fish
  echo "Installing fish goodies."
  mkdir -p ~/.config/fish/functions
  touch ~/.config/fish/functions/_void.fish
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  for plugin in $fisher_plugins
    fish -c "fisher install $plugin"
  end
  # Prefer zoxide (z replacement) over the older jethrokuan/z plugin to avoid
  # conflicts (see: __z: --add: unknown option). If zoxide is present, add
  # its fish initialization to the config.
  if uname -s | grep -q 'Linux'
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  else if uname -s | grep -q 'Darwin'
    brew install zoxide
  end
  if type -q zoxide
    if not grep -q "zoxide init fish | source" ~/.config/fish/config.fish
      echo "zoxide init fish | source" >> ~/.config/fish/config.fish
    end
  end
  curl -sS https://starship.rs/install.sh | sh
  echo "starship init fish | source" >> ~/.config/fish/config.fish 
else
  echo "Fish goodies already installed."
end

