local module = {
	"rmehri01/onenord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local colors = require("onenord.colors").load()
		require("onenord").setup({
			custom_highlights = {
				["MiniStarterHeader"] = { fg = colors.dark_blue },
				["MiniStarterSection"] = { fg = colors.blue },
			},
		})
	end,
}

return module
