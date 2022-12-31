module = {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})

		local wk = require("which-key")
		local mappings = {
			["T"] = { "<cmd>TodoTelescope<CR>", "Todo" },
		}

		wk.register(mappings, WKOpts)
	end,
}

return module
