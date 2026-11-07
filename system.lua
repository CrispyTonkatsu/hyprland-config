hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
end)

hl.config({
	input = {
		kb_options = "caps:swapescape",

		touchpad = {
			scroll_factor = 0.2,
			natural_scroll = true
		}
	},

	xwayland = {
		force_zero_scaling = true
	},
})
