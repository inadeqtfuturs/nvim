local module = {
	"numToStr/Comment.nvim",
	commit = "eb0a84a2ea42858a2bb3cdf5fabe54e7c700555d",
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})

		if WKOpts then
			local wk = require("which-key")

			local mappings = {
				B = { "Comment block" },
				C = {
					name = "Comment line",
					C = { "count" },
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
}

return module
