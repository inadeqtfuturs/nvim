local module = {}

function module.setup()
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
end

return module
