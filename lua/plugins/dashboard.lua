local module = {}

function module.init(use)
	use({
		"glepnir/dashboard-nvim",
		config = function()
			local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)

			local footer = {
				"loaded " .. num_plugins_loaded .. " plugins ",
			}

			vim.g.dashboard_default_executive = "telescope"
			vim.g.dashboard_custom_header = {
				"    ___      ___  ________           ___ ___    ",
				"   /  /|    |\\  \\|\\  _____\\         /  /|\\  \\   ",
				"  /  / /    \\ \\  \\ \\  \\__/         /  //\\ \\  \\  ",
				" /  / /      \\ \\  \\ \\   __\\       /  //  \\ \\  \\ ",
				"|\\  \\/        \\ \\  \\ \\  \\_|      /  //    \\/  /|",
				"\\ \\  \\         \\ \\__\\ \\__\\      /_ //     /  // ",
				" \\ \\__\\         \\|__|\\|__|     |__|/     /_ //  ",
				"  \\|__|                                 |__|/   ",
			}
			vim.g.dashboard_custom_section = {
				a = {
					description = { "  Find File          " },
					command = "Telescope find_files",
				},
				b = {
					description = { "  Recent Projects    " },
					command = "Telescope projects",
				},
				c = {
					description = { "  Recently Used Files" },
					command = "Telescope oldfiles",
				},
				d = {
					description = { "  Find Word          " },
					command = "Telescope live_grep",
				},
				e = {
					description = { "  Code Review        " },
					command = "Octo pr list labels=ready\\ for\\ review",
				},
			}
			vim.g.dashboard_custom_footer = footer
		end,
	})
end

return module
