local module = {}

function module.init(use)
	use({
		"kvrohit/substrata.nvim",
		config = function()
			vim.cmd([[
        colorscheme substrata
      ]])
		end,
	})
end

return module
