local module = {}

function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/nvim-lsp-installer" },
			{ "ray-x/lsp_signature.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function()
			-- on_attach
			local on_attach = function(client, bufnr)
				if client.name == "tsserver" then
					client.resolved_capabilities.document_formatting = false

					if client.config.flags then
						client.config.flags.allow_incremental_sync = true
					end
				end

				require("lsp_signature").on_attach({
					bind = true,
					hint_enable = false,
					handler_opts = {
						border = "single",
					},
				})

				if WKOpts then
					local wk = require("which-key")

					local mappings = {
						a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
						d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
						I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Show implementation" },
						K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
						r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
						s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
						l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show line diagnostics" },
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

				vim.diagnostic.open_float = (function(orig)
					return function(bufnr, opts)
						local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
						local opts = opts or {}
						-- A more robust solution would check the "scope" value in `opts` to
						-- determine where to get diagnostics from, but if you're only using
						-- this for your own purposes you can make it as simple as you like
						local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
						local max_severity = vim.diagnostic.severity.HINT
						for _, d in ipairs(diagnostics) do
							-- Equality is "less than" based on how the severities are encoded
							if d.severity < max_severity then
								max_severity = d.severity
							end
						end
						orig(bufnr, opts)
					end
				end)(vim.diagnostic.open_float)

				vim.diagnostic.config({
					virtual_text = false,
				})

				-- Show line diagnostics in floating popup on hover, except insert mode (CursorHoldI)
				vim.o.updatetime = 250
				vim.cmd(
					[[autocmd CursorHold * lua vim.diagnostic.open_float(0, {focus=false, scope="cursor", border="rounded"})]]
				)
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
					virtual_text = false,
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
					require("null-ls").builtins.code_actions.eslint_d,

					-- lua
					require("null-ls").builtins.formatting.stylua,

					-- php
					require("null-ls").builtins.formatting.phpcbf,

					-- ruby
					require("null-ls").builtins.diagnostics.rubocop,
					require("null-ls").builtins.formatting.rubocop,
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
