local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 11.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Use X11 so GNOME/WhiteSur draws the native window decoration,
-- including the macOS-style traffic-light controls.
config.enable_wayland = false
config.window_decorations = 'TITLE | RESIZE'

-- Cyberpunk / Scarlet Protocol palette.
config.color_scheme = 'Scarlet Protocol'
config.window_background_opacity = 0.98
config.text_background_opacity = 1.0
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.65,
}

-- Compact neon tab bar that blends with the palette.
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = false
config.colors = {
  background = '#0b0714',
  tab_bar = {
    background = '#08050f',
    active_tab = {
      bg_color = '#ff0051',
      fg_color = '#ffffff',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#151025',
      fg_color = '#c7c7c7',
    },
    inactive_tab_hover = {
      bg_color = '#ca30c7',
      fg_color = '#ffffff',
      italic = true,
    },
  },
}

config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}

return config
