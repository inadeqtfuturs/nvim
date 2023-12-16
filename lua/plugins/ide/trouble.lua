module = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local wk = require("which-key")
		local mappings = {
			["t"] = { "<cmd>TroubleToggle<CR>", "Trouble" },
		}

		wk.register(mappings, WKOpts)
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}

return module
