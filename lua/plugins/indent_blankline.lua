local module = {}

function module.init(use)
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				use_treesitter = true,
				buftype_exclude = { "terminal", "nofile", "dashboard", "lsp-installer", "lspinfo" },
				filetype_exclude = { "help", "terminal", "dashboard", "packer" },
				space_char_blankline = " ",
			})

			vim.opt.list = true
		end,
	})
end

return module
