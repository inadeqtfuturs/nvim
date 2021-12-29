local module = {}

function module.init(use)
	use({
		"arzg/vim-substrata",
		config = function()
			vim.cmd([[
        colorscheme substrata
      ]])
		end,
	})
end

return module
