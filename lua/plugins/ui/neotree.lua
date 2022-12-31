local module = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		local mappings = {
			["e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
		}
		require("which-key").register(mappings, WKOpts)

		require("nvim-web-devicons").has_loaded()

		require("neo-tree").setup({
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,

			default_component_configs = {
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "",
						modified = "",
						deleted = "✖",
						renamed = "",
						-- Status type
						untracked = "*",
						ignored = "◌",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},

			window = {
				position = "right",
				mappings = {
					["<C-v>"] = "open_vsplit",
					["s"] = "noop",
					["/"] = "noop",
				},
			},

			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = true,
			},
			buffers = {},
			git_status = {},
			source_selector = {
				winbar = true,
				statusline = false,
			},
		})
	end,
}

return module
