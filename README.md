# Dotfiles

My Linux/macOS terminal setup and a handful of personal utilities. The visual
theme combines WhiteSur window decorations with Scarlet Protocol, Starship and
an animated Samurai greeting.

## What's included

- **WezTerm:** dark Scarlet Protocol theme with a compact neon tab bar.
- **Starship:** single-line prompt with directory, Git status, command duration
  and exit status.
- **Fish:** Samurai greeting, Starship, zoxide and optional plugins.
- **Vim:** Vim-Plug, Coc and the Cyberpunk theme.
- **Kitty:** legacy Kitty configuration and color scheme.

## Installation

Clone the repository, enter it and run only the installers you need.

### WezTerm and Starship

```bash
./terminal/install.sh
```

Installs `~/.wezterm.lua` and `~/.config/starship.toml`. Existing files are
backed up with a timestamp before being replaced. WezTerm and Starship must
already be installed.

### Fish

```fish
fish ./fish/install.sh
```

Installs Fisher plugins, zoxide and Starship. The tracked `fish/config/config.fish`
contains the Samurai greeting and shell initialization.

### Vim

```bash
./vim/install.sh
```

Requires Node.js. Installs Vim-Plug, the plugins from `vim/.vimrc` and the
Cyberpunk theme.

## Utilities

| Command | Purpose |
| --- | --- |
| `scripts/printing/greeting.py --image img/ascii/samurai` | Animated Samurai greeting |
| `scripts/net/externaip.sh EMAIL TIMEOUT` | Notify by email when the public IP changes |
| `3sh HOST` | SSH compatibility helper for hosts that require `TERM=xterm-color` |
| `./test.sh` | Open an Ubuntu Docker environment for manual testing |

> The network utility requires `curl`, `mailx` and a working mail setup.
