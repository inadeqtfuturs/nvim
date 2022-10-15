local module = {}

function module.setup(client)
	local lsp = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},
		diagnostic = {
			virtual_text = false,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				winblend = 0,
			},
		},
	}

	-- signs
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = "Info", numhl = "Info" })
	end

	vim.diagnostic.config(lsp.diagnostic)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp.float)

	-- signature
	require("lsp_signature").on_attach({
		bind = true,
		hint_enable = false,
		handler_opts = {
			border = "single",
		},
	})

	if client.name == "null-ls" then
		client.resolved_capabilities.document_formatting = true
		client.resolved_capabilities.document_range_formatting = true
		vim.cmd([[
       augroup Format
         au! * <buffer>
         au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
       augroup END
     ]])
	end
end

return module
