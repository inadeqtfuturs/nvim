local module = {}

function module.setup(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	if WKOpts then
		local wk = require("which-key")

		vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

		local keymap_g = {
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
			I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Show implementation" },
			K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
			l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show line diagnostics" },
		}

		local keymap_l = {
			l = {
				name = "LSP",
				a = { "<cmd>Telescope lsp_code_actions<CR>", "Code Action" },
				d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
				r = { "<cmd>Telescope lsp_references<CR>", "References" },
				s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
			},
		}

		wk.register(keymap_g, {
			mode = "n",
			prefix = "g",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		wk.register(keymap_l, WKOpts)
	end
end

return module
