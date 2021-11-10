local module = {}

function module.init(use)
	use({
		"ms-jpq/chadtree",
		config = function()
			local chadtree_settings = {
				view = {
					open_direction = "right",
				},

				theme = {
					text_colour_set = "nord",
					discrete_colour_map = {
						blue = "#84a0c6",
					},
				},
			}

			vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
		end,
	})
end

return module
