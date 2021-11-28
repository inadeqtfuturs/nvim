local module = {}

function module.init(use)
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					b = { "Comment block" },
					c = {
						name = "Comment line",
						c = { "count" },
					},
				}

				wk.register(mappings, {
					mode = "n",
					prefix = "g",
					buffer = nil,
					silent = true,
					noremap = true,
					nowait = true,
				})

				wk.register(mappings, {
					mode = "v",
					prefix = "g",
					buffer = nil,
					silent = true,
					noremap = true,
					nowait = true,
				})
			end
		end,
	})
end

return module
