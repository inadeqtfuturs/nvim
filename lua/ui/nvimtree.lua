local module = {}

function module.init(use)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				open_on_setup = false,
				view = {
					side = "right",
					width = 40,
				},
				update_focused_file = {
					enable = true,
					update_cwd = false,
				},
				git = {
					ignore = false,
				},
			})

			local mappings = {
				["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
			}
			require("which-key").register(mappings, WKOpts)
		end,
	})
end

return module
