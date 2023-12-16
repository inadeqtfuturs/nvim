local module = {
	"inadeqtfuturs/substrata.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[
        colorscheme substrata

        hi link WhichKeySeparator constant
      ]])
	end,
}

return module
