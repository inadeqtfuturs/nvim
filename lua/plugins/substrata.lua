local module = {}

function module.init(use)
	use({
		"inadeqtfuturs/substrata.nvim",
		config = function()
			vim.cmd([[
        colorscheme substrata

        hi link WhichKeySeparator constant
      ]])
		end,
	})
end

return module
