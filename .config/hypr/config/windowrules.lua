hl.window_rule({
	name = "float_pavu",
	match = {
		class = "^(pavucontrol)$",
		float = true,
	},
})

hl.window_rule({
	name = "pavu",
	match = {
		class = "^(pavucontrol)$",
	},
	size = { 900, 600 },
})

hl.window_rule({
	name = "blueman",
	match = {
		class = "^(blueman-manager)$",
		float = true,
	},
})

hl.window_rule({
	name = "nm-connection",
	match = {
		class = "^(nm-connection-editor)$",
		float = true,
	},
})

hl.window_rule({
	name = "Dolphin",
	match = {
		class = "^(org.kde.dolphin)$",
		title = "^(Properties)$",
		float = true,
	},
})

hl.window_rule({
	name = "Open File",
	match = {
		class = "^(org.kde.dolphin)$",
		title = "^(Open File)$",
		float = true,
	},
})

hl.window_rule({
	name = "Float_Zen",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
		float = true,
	},
})

hl.window_rule({
	name = "Float_Zen",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
		pin = true,
	},
})
