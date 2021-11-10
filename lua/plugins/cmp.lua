local module = {}

function module.init(use)
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },

			-- vsnip
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },

			-- luasnip
			-- { "L3MON4D3/LuaSnip" },
			-- { "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local cmp = require("cmp")

			local kind_icons = {
				Class = " ",
				Color = " ",
				Constant = "ﲀ ",
				Constructor = " ",
				Enum = "練",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = "",
				Folder = " ",
				Function = " ",
				Interface = "ﰮ ",
				Keyword = " ",
				Method = " ",
				Module = " ",
				Operator = "",
				Property = " ",
				Reference = " ",
				Snippet = " ",
				Struct = " ",
				Text = " ",
				TypeParameter = " ",
				Unit = "塞",
				Value = " ",
				Variable = " ",
			}

			local source_names = {
				nvim_lsp = "(LSP)",
				emoji = "(Emoji)",
				path = "(Path)",
				calc = "(Calc)",
				cmp_tabnine = "(Tabnine)",
				vsnip = "(Snippet)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
			}

			local duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			}

			local duplicates_default = 0

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
						-- require("luasnip").lsp_expand(args.body)
					end,
				},

				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				},

				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					-- { name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),

				-- experimental
				experimental = {
					ghost_text = false,
					native_menu = false,
				},

				-- formatting
				formatting = {
					fields = { "kind", "abbr", "menu" },
					kind_icons = kind_icons,
					source_names = source_names,
					duplicates = duplicates,
					duplicates_default = duplicates_default,
					format = function(entry, vim_item)
						vim_item.kind = kind_icons[vim_item.kind]
						vim_item.menu = source_names[entry.source.name]
						vim_item.dup = duplicates[entry.source.name] or duplicates_default
						return vim_item
					end,
				},
			})
		end,
	})
end

return module
