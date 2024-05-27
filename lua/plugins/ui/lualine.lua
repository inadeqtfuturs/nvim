local project_root = {
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end,
	separator = "",
}

local module = {
	"nvim-lualine/lualine.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", opt = true } },

	config = function()
		require("lualine").setup({
			options = {
				theme = "onenord",
				globalstatus = true,
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { "dashboard", "NvimTree", "neo-tree", "packer" },
			},
			sections = {
				lualine_b = {
					project_root,
					{
						"branch",
						icon = nil,
						icons_enabled = false,
					},
					{
						"diff",
						diff_color = {
							added = "diffAdded",
							modified = "diffChanged",
							removed = "diffRemoved",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", hint = " ", info = " " },
						colored = true,
					},
					{
						function(msg)
							msg = msg or "inactive"
							local buf_clients = vim.lsp.buf_get_clients()
							local buf_client_names = {}

							for _, client in pairs(buf_clients) do
								if client.name ~= "null-ls" then
									table.insert(buf_client_names, client.name)
								end
							end

							return "[" .. table.concat(buf_client_names, ", ") .. "]"
						end,
					},
				},
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		})
	end,
}

return module
