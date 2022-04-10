local module = {}

-- convert to
function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/nvim-lsp-installer" },
			{ "ray-x/lsp_signature.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "simrat39/rust-tools.nvim" },
		},

		config = function()
			local servers = {
				-- eslint = {
				-- 	settings = {
				-- 		codeActions = {
				-- 			enable = false,
				-- 		},
				-- 		format = true,
				-- 	},
				-- },
				cssls = {},
				jsonls = {},
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
				sumneko_lua = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				tsserver = {},
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if package.loaded["cmp_nvim_lsp"] then
				capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
			end

			local function on_attach(client)
				require("plugins.lsp.keymaps").setup()
				require("plugins.lsp.highlighter").setup()
				require("plugins.lsp.handlers").setup(client)
			end

			local opts = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			-- servers
			require("plugins.lsp.installer").setup(servers, opts)

			-- null-ls
			require("null-ls").setup({
				sources = {
					-- js
					-- require("null-ls").builtins.formatting.eslint_d,
					require("null-ls").builtins.formatting.prettier,
					require("null-ls").builtins.diagnostics.eslint_d,
					require("null-ls").builtins.code_actions.eslint_d,

					-- lua
					require("null-ls").builtins.formatting.stylua,

					-- php
					require("null-ls").builtins.formatting.phpcbf,

					-- ruby
					require("null-ls").builtins.diagnostics.rubocop,
					require("null-ls").builtins.formatting.rubocop,

					-- rust
					require("null-ls").builtins.formatting.rustfmt,

					-- spellcheck
					require("null-ls").builtins.diagnostics.codespell,
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	})
end

return module
