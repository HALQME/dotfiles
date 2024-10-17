-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- imput method
config.use_ime = true

-- tab_bar
config.show_new_tab_button_in_tab_bar = false
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = false

-- windows setting
config.initial_rows = 64
config.initial_cols = 192
config.window_decorations = "INTEGRATED_BUTTONS"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = '0px',
	right = '0px',
	bottom = '0px',
	top = '24pt',
}
config.enable_scroll_bar = false

-- color scheme and face:
config.color_scheme = "Catppuccin Mocha"
config.text_background_opacity = 1
config.window_background_opacity = 0.8

-- Background pics
local homedir = os.getenv("HOME")
-- -- put your images in the following directory "~/Hoge/Fuga……"
local images = {
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41ZQAL4.info/Ver.1.5_2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41AFJVZ.info/FlPSIMOaAAA3ZIZ.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41P8UXZ.info/2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41S0K3H.info/2560-1440.png",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41FCF42.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41FQWSN.info/Fm_cCB6XoAMk_BU.png",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N4168JB8.info/張家界2560x1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41UD4ZN.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41DZU2A.info/2560×1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41CD99W.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41R6RDW.info/FlPR8l1akAAtHaN.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N41P5QW7.info/2560-1440.jpg",
	homedir .. "/Pictures/Pictures.library/images/LMLH5N417GZQD.info/1.2KV2_2560x1440.jpg",
}

-- 配列からランダムな画像を選択する関数
local function get_random_image()
	math.randomseed(os.time())
	local index = math.random(1, #images)
	return images[index]
end

-- ウィンドウが再読み込みされるたびにランダムな画像を設定
local function set_background_image(window, pane)
	local overrides = window:get_config_overrides() or {}
	local random_image = get_random_image()
	overrides.background = {
		{
			source = {
				File = random_image,
			},
			opacity = 0.80,
			hsb = { brightness = 0.04 },
		},
	}
	window:set_config_overrides(overrides)
	pane:set_config_overrides(overrides)
end

wezterm.on("window-focus-changed", function(window, pane)
	set_background_image(window, pane)
end)
wezterm.on("window-config-reloaded", function(window, pane)
	set_background_image(window, pane)
end)

-- fonts
config.font = wezterm.font_with_fallback({ "Moralerspace Xenon NF" })
config.font_size = 14.5
config.adjust_window_size_when_changing_font_size = false

-- cursor conf
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 750

-- leader
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }

-- and finally, return the configuration to wezterm
return config
