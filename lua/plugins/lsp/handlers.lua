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
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
		vim.cmd([[
       augroup Format
         au! * <buffer>
         au BufWritePre <buffer> lua vim.lsp.buf.format()
       augroup END
     ]])
	end
end

return module
