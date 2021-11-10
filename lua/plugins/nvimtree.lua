local module = {}

function module.init(use)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				view = {
					side = "right",
					width = 40,
				},
			})
		end,
	})
end

return module
