local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Tab Bar
config.tab_max_width = 50
config.use_fancy_tab_bar = false
config.window_frame = {
  font = wezterm.font('Source Code Pro'),
  font_size = 10.0
}

-- Appearance
-- config.color_scheme = 'Kasugano (terminal.sexy)'
config.color_scheme = 'nightfox'
config.window_background_opacity = 0.9
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}
config.font = wezterm.font('Source Code Pro')
config.font_size = 10.0

-- Keyboard
config.keys = {
  {
    key = ')',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '(',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  { 
    key = '{', 
    mods = 'CTRL|SHIFT', 
    action = wezterm.action.ActivateTabRelative(-1) 
  },
  {
    key = '}', 
    mods = 'CTRL|SHIFT', 
    action = wezterm.action.ActivateTabRelative(1) 
  },

}



-- Misc
config.enable_scroll_bar = true

-- Fixes
config.enable_wayland = false

-- Disable Autoupdate
check_for_updates = false
config.show_update_window = false

return config

