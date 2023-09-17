local module = {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = "<c-t>",
			direction = "horizontal",
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			close_on_exit = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			hidden = true,
			float_opts = { border = "curved" },
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		if WKOpts then
			local wk = require("which-key")

			local mappings = {
				G = { "<cmd>lua _lazygit_toggle()<CR>", "LazyGit" },
			}

			wk.register(mappings, WKOpts)
		end
	end,
}

return module
