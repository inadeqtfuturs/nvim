local module = {}

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

			local opts = {
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local vopts = {
				mode = "v",
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local mappings = {
				[";"] = { "<cmd>Dashboard<CR>", "Dashboard" },
				["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Toggle" },
				["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
				["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
				["f"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
				["w"] = { "<cmd>w!<CR>", "Save" },
				["q"] = { "<cmd>q!<CR>", "Quit" },

				b = {
					name = "Buffers",
					j = { "<cmd>BufferPick<cr>", "Jump" },
					f = { "<cmd>Telescope buffers<cr>", "Find" },
					b = { "<cmd>b#<cr>", "Previous" },
					w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
					e = {
						"<cmd>BufferCloseAllButCurrent<cr>",
						"Close all but current",
					},
					h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
					l = {
						"<cmd>BufferCloseBuffersRight<cr>",
						"Close all to the right",
					},
					D = {
						"<cmd>BufferOrderByDirectory<cr>",
						"Sort by directory",
					},
					L = {
						"<cmd>BufferOrderByLanguage<cr>",
						"Sort by language",
					},
				},

				p = {
					name = "Packer",
					c = { "<cmd>PackerCompile<cr>", "Compile" },
					i = { "<cmd>PackerInstall<cr>", "Install" },
					s = { "<cmd>PackerSync<cr>", "Sync" },
					S = { "<cmd>PackerStatus<cr>", "Status" },
					u = { "<cmd>PackerUpdate<cr>", "Update" },
				},

				s = {
					name = "Search",
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
					f = { "<cmd>Telescope find_files<cr>", "Find File" },
					h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
					M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
					r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
					R = { "<cmd>Telescope registers<cr>", "Registers" },
					t = { "<cmd>Telescope live_grep<cr>", "Text" },
					k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
					C = { "<cmd>Telescope commands<cr>", "Commands" },
					p = {
						"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
						"Colorscheme with Preview",
					},
				},
			}

			local vmappings = {
				["/"] = { "<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>", "Comment" },
			}

			require("which-key").register(mappings, opts)
			require("which-key").register(vmappings, vopts)
		end,
	})
end

return module
