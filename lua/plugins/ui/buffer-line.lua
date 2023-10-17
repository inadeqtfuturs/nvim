local module = {
	"akinsho/bufferline.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" }, { "moll/vim-bbye" } },
	commit = "688cdc30643f67db2d619bd4d8e0519f36f1c464",
	config = function()
		require("bufferline").setup({})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
		map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

		if WKOpts then
			local wk = require("which-key")

			local mappings = {
				b = {
					name = "Buffers",
					j = { "<cmd>BufferLinePick<cr>", "Jump" },
					f = { "<cmd>Telescope buffers<cr>", "Find" },
					h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
					l = {
						"<cmd>BufferLineCloseRight<cr>",
						"Close all to the right",
					},
				},
			}

			wk.register(mappings, WKOpts)
		end
	end,
}

return module
