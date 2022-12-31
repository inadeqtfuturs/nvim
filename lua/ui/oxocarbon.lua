local module = {}

function module.init(use)
	use({
		"shaunsingh/oxocarbon.nvim",
		branch = "fennel",
		config = function()
			vim.cmd([[
        colorscheme oxocarbon
      ]])
		end,
	})
end

return module
