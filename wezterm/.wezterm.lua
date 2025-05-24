-- WezTerm Keybindings
-- ===================================================
-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - LEADER + \: Split the current pane horizontally into two panes.
--    - LEADER + -: Split the current pane vertically into two panes.

-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying ( 󰓥 ).

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.

-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "rose-pine"
config.font = wezterm.font("0xProto Nerd Font")
config.font_size = 16
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "RESIZE"

-- Keybinds
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
}

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- Tab Bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Tab Bar appearance
config.colors = {
	tab_bar = {
		background = "#232136",
		active_tab = {
			bg_color = "#232136",
			fg_color = "#3e8fb0",
		},
		inactive_tab = {
			bg_color = "#232136",
			fg_color = "#575279",
		},
		inactive_tab_hover = {
			bg_color = "#2a283e",
			fg_color = "#e0def4",
		},
		new_tab = {
			bg_color = "#232136",
			fg_color = "#575279",
		},
		new_tab_hover = {
			bg_color = "#2a283e",
			fg_color = "#e0def4",
		},
	},
	-- the foreground color of selected text
	selection_fg = "#e0def4",
	-- the background color of selected text
	selection_bg = "#403d52",
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- Tab Bar Title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	-- local title = pane.foreground_process_name
	local title = basename(pane.foreground_process_name)
	local index = (tab.tab_index + 1)
	local color = "navy"

	return {

		{ Text = " " .. index .. ": " .. title .. " " },
	}
end)

-- Leader Key Status
wezterm.on("update-right-status", function(window, pane)
	local leader = ""
	if window:leader_is_active() then
		leader = " 󰓥 "
	end
	window:set_right_status(leader)
end)

-- Maximize wezterm on startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- Return the configuration to wezterm
return config
