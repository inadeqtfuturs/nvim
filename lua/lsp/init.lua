local module = {}

-- convert to
function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
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
				sumneko_lua = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				tsserver = {
					init_options = {
						plugins = {
							{
								name = "typescript-styled-plugin",
								location = os.getenv("HOME") .. "/.nvm/versions/node/v17.6.0/lib",
							},
						},
						preferences = {
							disableSuggestions = true,
						},
					},
				},
				yamlls = {},
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

				require("lsp.keymaps").setup(bufnr)
				require("lsp.highlighter").setup()
				require("lsp.handlers").setup(client)
			end

			local opts = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			-- servers
			require("mason").setup()
			require("lsp.installer").setup(servers, opts)

			-- null-ls
			require("null-ls").setup({
				sources = {
					-- js
					require("null-ls").builtins.diagnostics.eslint_d,
					require("null-ls").builtins.formatting.eslint_d,
					require("null-ls").builtins.code_actions.eslint_d,

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
						args = {
							"-c",
							"~/.rubocop.yml",
							"-f",
							"json",
							"--stdin",
							"$FILENAME",
						},
					}),

					-- rust
					require("null-ls").builtins.formatting.rustfmt,

					-- spellcheck
					require("null-ls").builtins.diagnostics.codespell,
					-- require("null-ls").builtins.formatting.codespell,
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	})

	initialize(use, "lsp", { "cmp", "cool" })
end

return module
