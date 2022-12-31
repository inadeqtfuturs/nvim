local module = {
	"nvim-lualine/lualine.nvim",
	dependencies = { { "kyazdani42/nvim-web-devicons", opt = true } },

	config = function()
		require("lualine").setup({
			options = {
				theme = "nord",
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
				disabled_filetypes = { "dashboard", "NvimTree", "neo-tree", "packer" },
			},
			sections = {
				lualine_b = {
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
						colored = false,
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
