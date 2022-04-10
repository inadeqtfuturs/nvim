local module = {}

function module.setup(client)
	-- signature
	require("lsp_signature").on_attach({
		bind = true,
		hint_enable = false,
		handler_opts = {
			border = "single",
		},
	})

	-- signs
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = "Info", numhl = "Info" })
	end

	if client.name ~= "tsserver" then
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
	else
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	vim.diagnostic.config({
		virtual_text = false,
	})

	vim.cmd([[
    augroup Format
      au! * <buffer>
      au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
    augroup END
  ]])
end

return module
