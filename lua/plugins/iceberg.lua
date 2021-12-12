local module = {}

function module.init(use)
	use({
		"cocopon/iceberg.vim",
		config = function()
			vim.cmd([[
        colorscheme iceberg
        highlight DiagnosticWarn guifg=#e2a478
        highlight DiagnosticUnderlineWarn guisp=#e2a478
        highlight DiagnosticError guifg=#e27878
        highlight DiagnosticUnderlineError guisp=#e27878
      ]])
		end,
	})
end

return module
