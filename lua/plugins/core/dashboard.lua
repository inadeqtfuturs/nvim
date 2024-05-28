local module = {
	"glepnir/dashboard-nvim",
	priority = 1001,
	event = "VimEnter",
	opts = {
		theme = "doom",
		config = {
			header = {
				"",
				"",
				"",
				"Feelin' fine.",
				"",
				"",
				"",
			},
			center = {
				{
					icon = "  ",
					desc = "Find File          ",
					action = "Telescope find_files",
				},
				{
					icon = "  ",
					desc = "Recently Used Files",
					action = "Telescope oldfiles",
				},
				{
					icon = "  ",
					desc = "Find Word          ",
					action = "Telescope live_grep",
				},
			},
		},
	},
}

return module
