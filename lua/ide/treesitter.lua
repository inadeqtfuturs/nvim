local module = {}

function module.init(use)
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "addc129a4f272aba0834bd0a7b6bd4ad5d8c801b",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
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
	})
end

return module
