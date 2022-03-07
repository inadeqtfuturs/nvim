local module = {}

function module.init(use)
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
			--
			-- if WKOpts then
			-- 	local wk = require("which-key")
			--
			-- 	local mappings = {
			-- 		O = {
			-- 			name = "Octo",
			-- 			c = {
			-- 				name = { "Comment" },
			-- 				a = { "<cmd>Octo comment add<cr>", "Add" },
			-- 				d = { "<cmd>Octo comment delete<cr>", "Delete" },
			-- 			},
			-- 		},
			-- 	}
			--
			-- 	wk.register(mappings, WKOpts)
			-- end

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					O = {
						name = "Octo",
						p = {
							name = "PR",
							l = { "<cmd>Octo pr list<cr>", "List" },
							s = { "<cmd>Octo pr search<cr>", "Search" },
							c = { "<cmd>Octo pr commits<cr>", "Commits" },
							b = { "<cmd>Octo pr browser<cr>", "Browser" },
							u = { "<cmd>Octo pr url<cr>", "URL" },
						},
						R = {
							name = "Review",
							s = { "<cmd>Octo review start<cr>", "Start" },
							d = { "<cmd>Octo review submit<cr>", "Done - submit" },
							r = { "<cmd>Octo review resume<cr>", "Resume" },
							t = { "<cmd>Octo review discard<cr>", "Trash - discard" },
							c = { "<cmd>Octo review comments<cr>", "Comments" },
						},
						r = {
							name = "Repo",
							l = { "<cmd>Octo repo list<cr>", "List" },
							b = { "<cmd>Octo repo browser<cr>", "Browser" },
							u = { "<cmd>Octo repo url<cr>", "URL" },
						},
						c = {
							name = "Comment",
							a = { "<cmd>Octo comment add<cr>", "Add" },
							d = { "<cmd>Octo comment delete<cr>", "Delete" },
						},
						a = { "<cmd>Octo actions<cr>", "Actions" },
						s = { "<cmd>Octo search<cr>", "Search" },
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
