local module = {}

function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "alexaandru/nvim-lspupdate" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/lsp-colors.nvim" },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local null_ls = require("null-ls")

			local servers = {
				"cssls",
				"bashls",
				"dockerls",
				"flow",
				"gopls",
				"html",
				"intelephense",
				"pyright",
				"jsonls",
				"rust_analyzer",
				"tsserver",
				"sourcekit",
				"solargraph",
        "sumneko_lua",
				"vimls",
				"vuels",
			}

			-- The nvim-cmp almost supports LSP's capabilities so You should
			-- advertise it to LSP servers..
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

			local on_attach = function(client)
				-- disable tsserver formatting
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				-- define an alias
				vim.cmd("command -buffer Formatting lua vim.lsp.buf.formatting()")
				vim.cmd("command -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")

				-- format on save -- USE SEQ_SYNC
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
			end

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
					on_attach = on_attach,
          settings = {
            lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
				})
			end

			null_ls.config({
				debug = true,
				sources = {
					-- formatting
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.json_tool,
					null_ls.builtins.formatting.lua_format,
					null_ls.builtins.formatting.nginx_beautifier,
					null_ls.builtins.formatting.phpcbf,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.sqlformat,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.shfmt,

					-- diagnostics
					null_ls.builtins.diagnostics.eslint_d,
					-- null_ls.builtins.diagnostics.luacheck,
				},
			})

			require("lspconfig")["null-ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- inline diagnostics
			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
				-- inline settings
				vim.lsp.diagnostic.on_publish_diagnostics,
				{
					virtual_text = true,
					underline = true,
					signs = true,
				},
				-- signs
				vim.fn.sign_define("LspDiagnosticsSignError", { text = "" }),
				vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "" }),
				vim.fn.sign_define("LspDiagnosticsSignHint", { text = "" }),
				vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "" })
			)
		end,
	})
end

return module
