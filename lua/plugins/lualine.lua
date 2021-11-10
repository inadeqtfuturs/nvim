local module = {}

function module.init(use)
	use({
		"nvim-lualine/lualine.nvim",
		requires = { { "kyazdani42/nvim-web-devicons", opt = true } },

		config = function()
			require("lualine").setup({
				options = {
					theme = "iceberg",
					disabled_filetypes = { "dashboard", "NvimTree", "packer" },
				},
			})
		end,
	})
end

return module
