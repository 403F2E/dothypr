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

-- File manager
hl.window_rule({
	name = "Open File",
	match = {
		class = "^(org.kde.dolphin)$",
		title = "^(Open File)$",
		float = true,
	},
})

-- Browsers
hl.window_rule({
	name = "browse",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
		float = true,
	},
	workspace = 2,
})
hl.window_rule({
	name = "browse",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
		pin = true,
	},
	workspace = 2,
})
hl.window_rule({
	name = "browse",
	match = {
		class = "brave-browser",
	},
	workspace = 2,
})

-- Terminal
hl.window_rule({
	name = "kitty-workspace",
	match = {
		class = "kitty",
	},
	workspace = 1,
})

-- Notes
hl.window_rule({
	name = "obsidian-workspace",
	match = {
		class = "obsidian",
	},
	workspace = 1,
})

-- Social media
hl.window_rule({
	name = "socials",
	match = {
		class = "discord",
	},
	workspace = 3,
})
hl.window_rule({
	name = "socials",
	match = {
		class = "com.rtosta.zapzap",
	},
	workspace = 3,
})

-- Music
hl.window_rule({
	name = "spotify-workspace",
	match = {
		class = "spotify",
	},
	workspace = 5,
})

-- Virtual-Manager
hl.window_rule({
	name = "virt-manager-workspace",
	match = {
		class = "virt-manager",
	},
	workspace = 5,
})

-- Streaming
hl.window_rule({
	name = "obs-workspace",
	match = {
		class = "com.obsproject.Studio",
	},
	workspace = 4,
})

-- Gaming
hl.window_rule({
	name = "steam-workspace",
	match = {
		class = "steam",
	},
	workspace = 8,
})
