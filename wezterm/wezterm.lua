local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font configuration
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 14.0
config.line_height = 1.2

-- Window appearance
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Scrollback
config.scrollback_lines = 10000

-- Performance
config.max_fps = 144
config.animation_fps = 60

-- Leader key configuration (like tmux prefix)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Key bindings
config.keys = {
	-- Send Ctrl+a when pressing leader twice (like tmux)
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- Pane navigation with Ctrl+hjkl (no prefix needed, like your tmux config)
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Previous pane (like tmux C-\)
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Prev"),
	},

	-- Split panes with leader key (like tmux prefix + | and -)
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Resize panes with leader + hjkl (like tmux prefix + hjkl)
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
	},

	-- Close pane (both leader+w and Cmd+w)
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Toggle zoom with leader+z (like tmux prefix + z)
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- Create new tab with leader+c (like tmux)
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Tab navigation with leader+n/p (like tmux)
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- Tab navigation with leader+number (like tmux)
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "6",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(5),
	},
	{
		key = "7",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(6),
	},
	{
		key = "8",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(7),
	},
	{
		key = "9",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(8),
	},

	-- Copy mode
	{
		key = "c",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCopyMode,
	},
}

-- Mouse bindings
config.mouse_bindings = {
	-- Right click pastes from clipboard
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}

-- Misc
config.check_for_updates = false
config.automatically_reload_config = true

return config
