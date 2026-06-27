local mainMod = "SUPER"

-- //-- Hyprland shutdown
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- //-- Mode Switching --//
local modes = "~/.config/hypr/scripts/mode.sh"

hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(modes))

-- //-- RELOAD
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- //-- LOCKSCREEN
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))

-- //-- LOGOUT
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wlogout"))

-- //-- Apps
local terminal = "kitty"
local obsidian = "flatpak run md.obsidian.Obsidian"
local fileManager = "dolphin"
local term_filemanager = terminal .. " -e ranger"
local fuzzing = terminal .. " -e ~/.config/hypr/scripts/fuzzing.sh"
local browser = "brave-browser"
local search = "~/.config/hypr/scripts/browse.sh"
local launcher = "~/.config/rofi/launchers/type-6/launcher.sh"
local calculator = "~/.config/hypr/scripts/calc.sh"

-- open kitty
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
-- open obsidian
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(obsidian))
-- open dolphin
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- open fzf
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(fuzzing))
-- open ranger
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd(term_filemanager))
-- open rofi -drun
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))
-- open brave (zen in the future)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- search through rofi
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(search))
-- open rofi calculator
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(calculator))

-- //-- Emojis
local emoji = "~/.config/hypr/scripts/emoji.sh"

hl.bind(mainMod .. " + code:60", hl.dsp.exec_cmd(emoji))

-- keybinds to switch betwen layouts
local layout = "~/.config/hypr/scripts/layout.sh"

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(layout))

-- //-- Windows
-- Keybinds to manage windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Keybinds to move between windows
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next({ prev = true })) -- Change focus to another window
	hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized" })) -- Bring it to the top
end)

-- Move windows in a certain direction
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- //-- Workspaces
-- Keybinds to move between workspaces and move windows between them
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- //-- Mouse
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- //-- Misc
-- Screenshots
hl.bind("print", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/screenshot_$(date +%F_%T).png"))
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/Screenshots/screenshot_$(date +%F_%T).png')
)

-- CLipboard
local clippy = "~/.config/rofi/launchers/type-6/clippy.sh"

hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd(clippy))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pamixer -i 5 --allow-boost --set-limit 300"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- //-- TOUCHPAD
local touchpad = "~/.config/hypr/scripts/touchpadState.sh"
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(touchpad))
