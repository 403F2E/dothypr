hl.config({
	input = {
		kb_layout = "gb",

		follow_mouse = 1,

		sensitivity = 1,

		accel_profile = "flat",

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			disable_while_typing = true,
			scroll_factor = 1.0,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- //-- controle the state of the touchpad (enable/disable)
local handle = io.popen("head -n 1 ~/.config/hypr/state/touchpad.status")
local boolValue = true

if handle then
	-- Read the entire output
	local rawValue = handle:read("*a")
	handle:close()

	-- Remove trailing newline/whitespace
	local cleanValue = rawValue:gsub("%s+$", "")

	-- Now you can concatenate or convert
	boolValue = (cleanValue == "true")
end

hl.device({
	name = "alp0011:00-044e:120c",
	enabled = boolValue,
})
