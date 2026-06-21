hl.config({
	animations = {
		enabled = true,

		bezier = { {

			name = "detective",
			points = { 0.05, 0.9, 0.1, 1.0 },
		} },

		animation = {
			{
				name = "windows",
				enabled = true,
				speed = 1,
				curve = "detective",
			},

			{
				name = "windowsIn",
				enabled = true,
				speed = 1,
				curve = "detective",
			},

			{
				name = "windowsOut",
				enabled = true,
				speed = 1,
				curve = "detective",
			},

			{
				name = "border",
				enabled = true,
				speed = 1,
				curve = "default",
			},

			{
				name = "fade",
				enabled = true,
				speed = 1,
				curve = "default",
			},

			{
				name = "workspaces",
				enabled = true,
				speed = 1,
				curve = "detective",
			},
		},
	},
})
