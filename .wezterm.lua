local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {

    audible_bell = "Disabled",
    enable_tab_bar = false,
    font_size = 22,
 
    color_schemes = {
        ['Solarized Osaka'] = {
            foreground = '#839496',
            background = '#002b36',
            cursor_bg = '#839496',
            cursor_fg = '#002b36',
            cursor_border = '#839496',
            selection_fg = '#002b36',
            selection_bg = '#839496',
            ansi = {
                '#002b36',
                '#dc322f',
                '#859900',
                '#b58900',
                '#268bd2',
                '#d33682',
                '#2aa198',
                '#eee8d5',
            },
            brights = {
                '#073642',
                '#cb4b16',
                '#586e75',
                '#657b83',
                '#839496',
                '#6c71c4',
                '#93a1a1',
                '#fdf6e3',
            },
        },
    },

    color_scheme = 'Solarized Osaka',
    window_background_opacity = 0.95,

}

return config
