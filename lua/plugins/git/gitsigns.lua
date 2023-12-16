local module = {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("gitsigns").setup()

		-- highlighting
		vim.cmd([[
        augroup custom_highlight
          autocmd!
          au ColorScheme * highlight GitSignsCurrentLineBlame guifg=#8389a3
        augroup END
      ]])

		if WKOpts then
			local wk = require("which-key")

			local mappings = {
				name = "Gitsigns",
				b = { "Blame line" },
				p = { "Preview hunk" },
				R = { "Reset buffer" },
				r = { "Reset hunk" },
				s = { "Stage hunk" },
				S = { "Stage buffer" },
				U = { "Reset buffer index" },
				t = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame" },
				u = { "Undo stage hunk" },
			}

			local vmappings = {
				name = "Gitsigns",
				s = { "Stage hunk" },
				r = { "Reset hunk" },
			}

			wk.register(mappings, {
				mode = "n",
				prefix = "<leader>h",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})

			wk.register(vmappings, {
				mode = "v",
				prefix = "<leader>h",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})
		end
	end,
}

return module
