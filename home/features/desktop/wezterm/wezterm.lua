-- {{{ Import stuff & create config object
local wezterm = require("wezterm")
local colorscheme = require("colorscheme") -- injected by nix!

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
-- }}}

local font_size = 20.0

-- {{{ Theming
config.colors = wezterm.color.load_base16_scheme(colorscheme.source)

-- {{{ Window frame
config.window_frame = {
  font = wezterm.font({ family = colorscheme.fonts.monospace }),
  font_size = font_size,
  active_titlebar_bg = colorscheme.base00,
  inactive_titlebar_bg = colorscheme.base00,
}
-- }}}
-- {{{ Tab bar colors
config.colors.tab_bar = {
  background = colorscheme.base02,
  active_tab = {
    bg_color = colorscheme.base0A,
    fg_color = colorscheme.base00,
  },
  inactive_tab = {
    bg_color = colorscheme.base02,
    fg_color = colorscheme.base05,
  },
  inactive_tab_hover = {
    bg_color = colorscheme.base01,
    fg_color = colorscheme.base05,
  },
  new_tab = {
    bg_color = colorscheme.base02,
    fg_color = colorscheme.base05,
  },
  new_tab_hover = {
    bg_color = colorscheme.base02,
    fg_color = colorscheme.base05,
    italic = true,
  },
}
-- }}}
-- }}}
-- {{{ Main config options
config.adjust_window_size_when_changing_font_size = false -- Makes it work with fixed window sizes.
config.automatically_reload_config = true
config.font_size = font_size
config.use_fancy_tab_bar = false
config.disable_default_key_bindings = true
-- config.enable_kitty_keyboard = true -- Let's apps recognise more distinct keys
config.enable_csi_u_key_encoding = true -- For some reason I need this for all keybinds to work inside neovim.
-- }}}
-- {{{ Keybinds
-- }}}

-- and finally, return the configuration to wezterm
return config
