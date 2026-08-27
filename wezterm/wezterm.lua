local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 11.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

local function reset_pane_sizes(window, pane)
  local panes = window:active_tab():panes_with_info()
  if #panes ~= 2 then
    window:toast_notification(
      'WezTerm',
      'Size reset currently supports exactly two panes',
      nil,
      2500
    )
    return
  end

  local active
  for _, pane_info in ipairs(panes) do
    if pane_info.is_active then
      active = pane_info
      break
    end
  end

  local first, second = panes[1], panes[2]
  local side_by_side = first.top == second.top and first.height == second.height
  local current_size = side_by_side and active.width or active.height
  local other_size = side_by_side
      and (active == first and second.width or first.width)
      or (active == first and second.height or first.height)
  local target_size = math.floor((current_size + other_size) / 2)
  local difference = target_size - current_size

  if difference == 0 then
    return
  end

  local direction
  if side_by_side then
    local active_is_left = active.left < (active == first and second.left or first.left)
    if active_is_left then
      direction = difference > 0 and 'Right' or 'Left'
    else
      direction = difference > 0 and 'Left' or 'Right'
    end
  else
    local active_is_top = active.top < (active == first and second.top or first.top)
    if active_is_top then
      direction = difference > 0 and 'Down' or 'Up'
    else
      direction = difference > 0 and 'Up' or 'Down'
    end
  end

  window:perform_action(
    wezterm.action.AdjustPaneSize({ direction, math.abs(difference) }),
    pane
  )
end

-- Physical keys avoid dead-key issues with the US International layout.
config.keys = {
  {
    key = 'phys:Minus',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'phys:Backslash',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'f',
    mods = 'CTRL|ALT',
    action = wezterm.action.RotatePanes('Clockwise'),
  },
  {
    key = 'b',
    mods = 'CTRL|ALT',
    action = wezterm.action.RotatePanes('CounterClockwise'),
  },
  {
    key = 'n',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Right', 3 }),
  },
  {
    key = 'w',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Left', 3 }),
  },
  {
    key = 't',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Up', 3 }),
  },
  {
    key = 's',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Down', 3 }),
  },
  {
    key = 'r',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(reset_pane_sizes),
  },
}

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
