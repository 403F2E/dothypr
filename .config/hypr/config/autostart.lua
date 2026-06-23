hl.on("hyprland.start", function()
	-- wallpaper
	hl.exec_cmd("hyprpaper")

	-- idle
	hl.exec_cmd("hypridle")

	-- notifications
	hl.exec_cmd("dunst")

	-- clipboard history
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- polkit authentication
	hl.exec_cmd("hyprpolkitagent")

	-- status bar
	hl.exec_cmd("waybar")
end)
