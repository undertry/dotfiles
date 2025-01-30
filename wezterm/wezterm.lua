
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Grayscale (dark) (terminal.sexy)'
-- Spawn a fish shell in login mode
config.default_prog = { '/usr/bin/zsh', '-l' }
config.color_scheme = 'Retro'
config.window_background_opacity = 0.8
window_decorations = "NONE"
config.enable_tab_bar = false
config.font = wezterm.font("AnonymiceProNerdFontMono")
config.font_size = 13.0
config.window_close_confirmation = 'NeverPrompt'
config.default_cursor_style = 'BlinkingBar'
-- and finally, return the configuration to wezterm
config.tiling_desktop_environments = {
  'X11 LG3D',
  'X11 bspwm',
  'X11 i3',
  'X11 dwm',
}

return config

