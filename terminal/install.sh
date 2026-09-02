#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
backup_suffix="$(date +%Y%m%d-%H%M%S).bak"

install_config() {
  local source_file="$1"
  local target_file="$2"

  mkdir -p "$(dirname -- "$target_file")"
  if [[ -e "$target_file" || -L "$target_file" ]]; then
    cp -a -- "$target_file" "$target_file.$backup_suffix"
    printf 'Backed up %s\n' "$target_file"
  fi
  install -m 0644 -- "$source_file" "$target_file"
  printf 'Installed %s\n' "$target_file"
}

install_config "$repo_dir/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
install_config "$repo_dir/starship/starship.toml" "$HOME/.config/starship.toml"

install_config "$repo_dir/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
install_config "$repo_dir/ghostty/themes/Scarlet Protocol" "$HOME/.config/ghostty/themes/Scarlet Protocol"
install_config "$repo_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
