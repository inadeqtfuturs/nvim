local module = {
	"goolord/alpha-nvim",
	priority = 1001,
	event = "VimEnter",

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"",
			"Feelin' fine.",
			"",
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "   find file", ":Telescope find_files<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}

return module
