local module = {}

function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/nvim-lsp-installer" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function() end,
	})
end

return module
