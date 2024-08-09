local wezterm = require("wezterm")
local config = {}

config.window_background_opacity = 0.7

-- config.font = wezterm.font("JetBrains Mono Nerd Font Mono", { weight = "Bold", italic = true })

config.font = wezterm.font("Cascadia Code NF", { weight = "Bold", italic = true })
config.font_size = 13

config.window_decorations = "RESIZE"

config.colors = {
	scrollbar_thumb = "white",
}

return config
