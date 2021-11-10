local module = {}

function module.init(use)
	use({
		"williamboman/nvim-lsp-installer",
		require("nvim-lsp-installer").on_server_ready(function(server)
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
				-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")

				vim.cmd([[
          augroup Format
            au! * <buffer>
            au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
          augroup end
        ]])
			end

        local thing

			server:setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end),
	})
end

return module
