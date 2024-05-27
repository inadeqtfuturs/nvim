local module = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "ray-x/lsp_signature.nvim" },
		{ "jose-elias-alvarez/null-ls.nvim" },
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
			if client.name ~= "null-ls" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

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

		-- null-ls
		require("null-ls").setup({
			sources = {
				-- js
				require("null-ls").builtins.diagnostics.eslint_d,
				require("null-ls").builtins.formatting.eslint_d,
				require("null-ls").builtins.code_actions.eslint_d,

				-- liquid
				require("null-ls").builtins.formatting.prettier.with({
					filetypes = { "liquid" },
				}),

				-- json
				require("null-ls").builtins.formatting.fixjson,

				-- lua
				require("null-ls").builtins.formatting.stylua,

				-- php
				require("null-ls").builtins.formatting.phpcbf,

				-- ruby
				require("null-ls").builtins.diagnostics.rubocop.with({
					prefer_local = "bin",
				}),

				require("null-ls").builtins.formatting.rubocop.with({
					prefer_local = "bin",
				}),

				-- rust
				require("null-ls").builtins.formatting.rustfmt,

				-- spellcheck
				require("null-ls").builtins.diagnostics.codespell,
				-- require("null-ls").builtins.formatting.codespell,

				-- python
				require("null-ls").builtins.formatting.black,
			},
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}

return module
