local module = {}

function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/nvim-lsp-installer" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function()
			-- on_attach
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				-- Mappings.
				local opts = { noremap = true, silent = true }

				-- See `:help vim.lsp.*` for documentation on any of the below functions
				buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				buf_set_keymap("n", "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

				if WKOpts then
					local wk = require("which-key")

					local mappings = {
						a = { "Code action" },
						D = { "Go to declaration" },
						d = { "Go to definition" },
						I = { "Show implementation" },
						K = { "Show hover" },
						r = { "Rename" },
						s = { "Show signature help" },
						l = { "Show line diagnostics" },
					}

					wk.register(mappings, {
						mode = "n",
						prefix = "g",
						buffer = nil,
						silent = true,
						noremap = true,
						nowait = true,
					})
				end

				vim.cmd([[
          augroup Format
            au! * <buffer>
            au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
          augroup END
        ]])
			end

			-- signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = "Info", numhl = "Info" })
			end

			-- ui
			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
				-- inline settings
				vim.lsp.diagnostic.on_publish_diagnostics,
				{
					virtual_text = true,
					underline = true,
					signs = true,
					serverity_sort = true,
				}
			)

			local function get_config()
				local config = {}
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				if package.loaded["cmp_nvim_lsp"] then
					capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
				end
				config.on_attach = on_attach
				config.capabilities = capabilities

				-- set vim as global in lua
				config.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				}
				return config
			end

			local capabilities = require("cmp_nvim_lsp").update_capabilities(
				vim.lsp.protocol.make_client_capabilities()
			)

			-- null-ls
			require("null-ls").setup({
				sources = {
					-- js
					require("null-ls").builtins.formatting.eslint_d,
					require("null-ls").builtins.diagnostics.eslint_d,

					-- lua
					require("null-ls").builtins.formatting.stylua,
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			require("nvim-lsp-installer").on_server_ready(function(server)
				server:setup(get_config())
				vim.cmd([[ do User LspAttachBuffers ]])
			end)
		end,
	})
end

return module
