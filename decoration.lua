hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
	},

	decoration = {
		blur = {
			enabled = true,
		},
	},
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3,
	bezier = "default",
	style = "slidevert",
})
