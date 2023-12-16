local module = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			exclude = {
				buftypes = { "terminal", "nofile", "dashboard", "lsp-installer", "lspinfo" },
				filetypes = { "help", "terminal", "dashboard", "packer" },
			},
			scope = {
				enabled = false,
			},
			indent = {
				char = "│",
				tab_char = "│",
			},
		})

		vim.opt.list = true
	end,
}

return module
