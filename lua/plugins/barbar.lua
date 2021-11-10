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
		end,
	})
end

return module
