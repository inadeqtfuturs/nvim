local module = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				all = {
					text = "#b5b4c9",
					base = "#191c25",

					mauve = "#8296b0",
					red = "#cf8164",
					green = "#76a065",
					yellow = "#ab924c",
					blue = "#8296b0",
					peach = "#a18daf",
				},
			},
		})
		vim.cmd([[colorscheme catppuccin]])
	end,
}

return module
