local module = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "ray-x/lsp_signature.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "simrat39/rust-tools.nvim" },
	},

	config = function()
		local servers = {
			cssls = {
				filetypes = {
					"css",
					"scss",
					"less",
					"js",
					"jsx",
					"javascript",
					"javascriptreact",
				},
			},
			intelephense = {},
			jsonls = {},
			graphql = {},
			marksman = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = {
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
					},
				},
			},
			solargraph = {},
			stylelint_lsp = {
				settings = {
					stylelintplus = {
						-- see available options in stylelint-lsp documentation
						configFile = "./.stylelintrc.js",
						autoFixOnSave = true,
						autoFixOnFormat = true,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			pyright = {},
			theme_check = {
				root_dir = function()
					return vim.loop.cwd()
				end,
			},
			yamlls = {
				settings = {
					yaml = {
						keyOrdering = false,
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
			},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		if package.loaded["cmp_nvim_lsp"] then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local function on_attach(client, bufnr)
			require("plugins.lsp.keymaps").setup(bufnr)
			require("plugins.lsp.highlighter").setup()
			require("plugins.lsp.handlers").setup(client)
		end

		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- servers
		require("mason").setup()
		require("plugins.lsp.installer").setup(servers, opts)
		require("mason-tool-installer").setup({
			ensure_installed = Linters,
		})
		require("mason-tool-installer").setup({
			ensure_installed = Formatters,
		})
	end,
}

return module
