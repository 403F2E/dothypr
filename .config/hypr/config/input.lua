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
