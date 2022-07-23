local module = {}

WKOpts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

WKVOpts = {
	mode = "v",
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

function module.init(use)
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				plugins = {
					registers = true,
					presets = {
						operators = false,
						motions = false,
					},
				},
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				window = {
					border = "single", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
					padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				},
				layout = {
					height = { min = 4, max = 25 }, -- min and max height of the columns
					width = { min = 20, max = 50 }, -- min and max width of the columns
					spacing = 3, -- spacing between columns
				},
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
			})

			local mappings = {
				[";"] = { "<cmd>Dashboard<CR>", "Dashboard" },
				["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Toggle" },
				["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
				["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
				["E"] = { "<cmd>NvimTreeCollapse<CR>", "Collapse Explorer" },
				["f"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
				["w"] = { "<cmd>w!<CR>", "Save" },
				["q"] = { "<cmd>q!<CR>", "Quit" },

				p = {
					name = "Packer",
					c = { "<cmd>PackerCompile<cr>", "Compile" },
					i = { "<cmd>PackerInstall<cr>", "Install" },
					s = { "<cmd>PackerSync<cr>", "Sync" },
					S = { "<cmd>PackerStatus<cr>", "Status" },
					u = { "<cmd>PackerUpdate<cr>", "Update" },
				},
			}

			local vmappings = {
				["/"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
			}

			require("which-key").register(mappings, WKOpts)
			require("which-key").register(vmappings, WKVOpts)
		end,
	})
end

return module
