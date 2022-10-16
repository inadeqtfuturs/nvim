local module = {}

function module.init(use)
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "addc129a4f272aba0834bd0a7b6bd4ad5d8c801b",
		requires = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", "nvim-treesitter/playground" },
		},
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
				context_commentstring = {
					enable = true,
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
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})

			-- additional parser configs
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

			parser_config.markdown.filetype_to_parsername = "octo"

			parser_config.norg_meta = {
				install_info = {
					url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
					files = { "src/parser.c" },
					branch = "main",
				},
			}
			parser_config.norg_table = {
				install_info = {
					url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
					files = { "src/parser.c" },
					branch = "main",
				},
			}
		end,
	})
end

return module
