local module = {}

function module.init(use)
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = { { "kyazdani42/nvim-web-devicons" }, { "moll/vim-bbye" } },
		config = function()
			require("bufferline").setup({})
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
			map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

			function close_all()
				local current = vim.api.nvim_get_current_buf()
				local buffers = require("bufferline.utils").get_valid_buffers()
				for _, bufnr in pairs(buffers) do
					if bufnr ~= current then
						pcall(vim.cmd, string.format("bd %d", bufnr))
					end
				end
			end

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					b = {
						name = "Buffers",
						j = { "<cmd>BufferLinePick<cr>", "Jump" },
						f = { "<cmd>Telescope buffers<cr>", "Find" },
						e = {
							"<cmd>lua close_all()<cr>",
							"Close all but current",
						},
						h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
						l = {
							"<cmd>BufferLineCloseRight<cr>",
							"Close all to the right",
						},
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
