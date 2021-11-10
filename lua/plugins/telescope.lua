local module = {}

function module.init(use)
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },

		config = function() end,
	})
end

return module
