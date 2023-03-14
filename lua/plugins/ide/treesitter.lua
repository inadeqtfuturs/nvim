local module = {
	"nvim-treesitter/nvim-treesitter",
	dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			ignore_install = { "phpdoc", "markdown" },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			highlight = {
				use_languagetree = true,
				enable = true,
			},
			indent = {
				enable = true,
			},
			refactor = {
				highlight_definitions = { enable = false },
				highlight_current_scope = { enable = false },
			},
		})

		-- additional parser configs
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.markdown.filetype_to_parsername = "octo"
	end,
}

return module
