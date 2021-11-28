local module = {}

function module.init(use)
	use({
		"romgrk/barbar.nvim",
		requires = { { "kyazdani42/nvim-web-devicons" } },

		config = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			map("n", "<S-h>", ":BufferPrevious<CR>", opts)
			map("n", "<S-l>", ":BufferNext<CR>", opts)

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					b = {
						name = "Buffers",
						j = { "<cmd>BufferPick<cr>", "Jump" },
						f = { "<cmd>Telescope buffers<cr>", "Find" },
						b = { "<cmd>b#<cr>", "Previous" },
						w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
						e = {
							"<cmd>BufferCloseAllButCurrent<cr>",
							"Close all but current",
						},
						h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
						l = {
							"<cmd>BufferCloseBuffersRight<cr>",
							"Close all to the right",
						},
						D = {
							"<cmd>BufferOrderByDirectory<cr>",
							"Sort by directory",
						},
						L = {
							"<cmd>BufferOrderByLanguage<cr>",
							"Sort by language",
						},
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
