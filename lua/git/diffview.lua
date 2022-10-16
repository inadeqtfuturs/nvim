module = {}

function module.init(use)
	use({
		"sindrets/diffview.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},

		config = function()
			local actions = require("diffview.actions")

			require("diffview").setup({
				keymaps = {
					view = {
						["<leader>b"] = actions.focus_files,
						["<leader>e"] = actions.toggle_files,
					},
					file_pannel = {
						["<leader>b"] = actions.focus_files,
						["<leader>e"] = actions.toggle_files,
					},
					file_history_panel = {
						["<leader>b"] = actions.focus_files,
						["<leader>e"] = actions.toggle_files,
					},
				},
			})

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					D = { "<cmd>DiffviewOpen<cr>", "Diffview" },
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
