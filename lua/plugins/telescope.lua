local module = {}

function module.init(use)
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },

		config = function()
			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					s = {
						name = "Search",
						b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
						c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
						f = { "<cmd>Telescope find_files<cr>", "Find File" },
						h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
						M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
						r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
						R = { "<cmd>Telescope registers<cr>", "Registers" },
						t = { "<cmd>Telescope live_grep<cr>", "Text" },
						k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
						C = { "<cmd>Telescope commands<cr>", "Commands" },
						p = {
							"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
							"Colorscheme with Preview",
						},
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
