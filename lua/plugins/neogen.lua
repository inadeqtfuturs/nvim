local module = {}

function module.init(use)
	use({
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({})
			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					n = {
						name = "Neogen",
						d = { "<cmd>:Neogen<cr>", "Generate docs" },
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
