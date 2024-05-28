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

		local eslint_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js", "eslint.config.cjs" }
		local xo_config = { ".xo-config" }

		-- null-ls
		require("null-ls").setup({
			sources = {
				-- js
				require("null-ls").builtins.diagnostics.eslint_d.with({
					timeout = 10000,
					condition = function(utils)
						return utils.root_has_file(eslint_files)
					end,
					--[[ prefer_local = "node_modules/.bin", ]]
				}),
				require("null-ls").builtins.formatting.eslint_d.with({
					timeout = 20000,
					condition = function(utils)
						return utils.root_has_file(eslint_files)
					end,
					--[[ prefer_local = "node_modules/.bin", ]]
				}),
				require("null-ls").builtins.code_actions.eslint_d.with({
					timeout = 10000,
					condition = function(utils)
						return utils.root_has_file(eslint_files)
					end,
					--[[ prefer_local = "node_modules/.bin", ]]
				}),

				-- xo
				require("null-ls").builtins.diagnostics.xo.with({
					prefer_local = "node_modules/.bin",
					timeout = 10000,
					condition = function(utils)
						local xo = utils.root_has_file(xo_config)
						local es = utils.root_has_file(eslint_files)
						return xo and not es
					end,
				}),
				require("null-ls").builtins.code_actions.xo.with({
					prefer_local = "node_modules/.bin",
					timeout = 10000,
					condition = function(utils)
						local xo = utils.root_has_file(xo_config)
						local es = utils.root_has_file(eslint_files)
						return xo and not es
					end,
				}),

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
				--[[ require("null-ls").builtins.diagnostics.codespell, ]]
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
