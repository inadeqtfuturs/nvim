local module = {}

function module.setup()
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

	vim.cmd([[
    augroup Format
      au! * <buffer>
      au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
    augroup END
  ]])
end

return module
