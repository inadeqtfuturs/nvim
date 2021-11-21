local module = {}

function module.init(use)
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function() end,
	})
end

return module
