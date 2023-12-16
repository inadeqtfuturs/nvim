module = {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		local api = require("typescript-tools.api")
		require("typescript-tools").setup({
			tsserver_max_memory = "auto",
			tsserver_plugins = {
				-- for TypeScript v4.9+
				"@styled/typescript-styled-plugin",
			},
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			handlers = {
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80001 }),
			},
		})
	end,
}

return module
