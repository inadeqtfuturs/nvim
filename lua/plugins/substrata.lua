local module = {}

function module.init(use)
	use({
		"inadeqtfuturs/substrata.nvim",
		config = function()
			vim.cmd([[
        colorscheme substrata
      ]])
		end,
	})
end

return module
