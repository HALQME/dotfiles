-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- imput method
config.use_ime = true

-- tab_bar
config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false

-- windows setting
config.initial_rows = 60
config.initial_cols = 192
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- color scheme and face:
config.color_scheme = "Catppuccin Mocha"
config.text_background_opacity = 0.7
config.window_background_opacity = 0.6

-- Background pics
local homedir = os.getenv("HOME")
-- -- put your images in the following directory "~/Hoge/Fuga……"
local images = {
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41ZQAL4.info/Ver.1.5_2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41AFJVZ.info/FlPSIMOaAAA3ZIZ.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41P8UXZ.info/2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41S0K3H.info/2560-1440.png",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41FCF42.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N417GZQD.info/1.2KV2_2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41FQWSN.info/Fm_cCB6XoAMk_BU.png",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N4168JB8.info/張家界2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41UD4ZN.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41DZU2A.info/2560×1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41CD99W.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41R6RDW.info/FlPR8l1akAAtHaN.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41P5QW7.info/2560-1440.jpg",
}

-- 配列からランダムな画像を選択する関数
local function get_random_image()
	math.randomseed(os.time())
	local index = math.random(1, #images)
	return images[index]
end

-- ウィンドウが再読み込みされるたびにランダムな画像を設定
wezterm.on("window-focus-changed", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local random_image = get_random_image()
	overrides.background = {
		{
			source = {
				File = random_image,
			},
			opacity = 0.75,
			hsb = { brightness = 0.05 },
		},
	}
	window:set_config_overrides(overrides)
end)

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local random_image = get_random_image()
	overrides.background = {
		{
			source = {
				File = random_image,
			},
			opacity = 0.75,
			hsb = { brightness = 0.05 },
		},
	}
	window:set_config_overrides(overrides)
end)

-- fonts
config.font = wezterm.font_with_fallback({ "Moralerspace Argon HWNF" })
config.font_size = 13
config.adjust_window_size_when_changing_font_size = false

-- cursor conf
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 750
-- key binding
local act = wezterm.action
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "F", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "H", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "h", mods = "SHIFT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Ctrl+Shift+hで新しいペインを作成(画面を分割)
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "J", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "K", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "L", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "v", mods = "SHIFT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- Ctrl+Shift+vで新しいペインを作成(画面を分割)
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = " ", mods = "LEADER", action = act.QuickSelect },
	{ key = "x", mods = "CTRL", action = act.ActivateCopyMode },
	{ key = "q", mods = "LEADER|CTRL", action = act.ActivateCommandPalette },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
}
-- and finally, return the configuration to wezterm
return config
