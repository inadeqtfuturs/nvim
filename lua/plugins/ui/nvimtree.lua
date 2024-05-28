local root_cwd = function(path)
	return vim.fn.fnamemodify(path, ":t")
end

local module = {
	"kyazdani42/nvim-tree.lua",
	commit = "8b8d457",
	dependencies = "nvim-tree/nvim-web-devicons",
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
			renderer = {
				root_folder_label = root_cwd,
			},
		})

		local mappings = {
			["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
		}
		require("which-key").register(mappings, WKOpts)
	end,
}

return module
