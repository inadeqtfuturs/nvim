local module = {}

function module.init(use)
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<c-t>",
				direction = "float",
				close_on_exit = false,
			})
		end,
	})
end

return module
