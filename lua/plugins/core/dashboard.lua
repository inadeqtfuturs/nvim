local module = {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	opts = {
		theme = "doom",
		config = {
			header = {
				"    ___      ___  ________           ___ ___    ",
				"   /  /|    |\\  \\|\\  _____\\         /  /|\\  \\   ",
				"  /  / /    \\ \\  \\ \\  \\__/         /  //\\ \\  \\  ",
				" /  / /      \\ \\  \\ \\   __\\       /  //  \\ \\  \\ ",
				"|\\  \\/        \\ \\  \\ \\  \\_|      /  //    \\/  /|",
				"\\ \\  \\         \\ \\__\\ \\__\\      /_ //     /  // ",
				" \\ \\__\\         \\|__|\\|__|     |__|/     /_ //  ",
				"  \\|__|                                 |__|/   ",
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
				{
					icon = "  ",
					desc = "Code Review        ",
					action = "Octo pr list labels=ready\\ for\\ review",
				},
			},
		},
	},
}

return module
