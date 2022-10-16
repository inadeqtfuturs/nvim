local module = {}

function module.init(use)
	use({
		"glepnir/dashboard-nvim",
		config = function()
			local db = require("dashboard")

			db.custom_header = {
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
			}

			db.custom_center = {
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
			}

			db.custom_footer = {}
		end,
	})
end

return module
