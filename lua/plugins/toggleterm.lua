local module = {}

function module.init(use)
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<c-t>",
				direction = "float",
				close_on_exit = true,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>gg",
				"<cmd>lua _lazygit_toggle()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	})
end

return module
