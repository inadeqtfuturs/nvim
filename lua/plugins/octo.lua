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

			if WKOpts then
				local wk = require("which-key")

				local mappings = {
					O = {
						name = "Octo",
						C = {
							name = "Code Review",
							a = {
								name = "Add Label",
								d = { "<cmd>Octo label add ready\\ to\\ merge<cr>", "Ready to Merge" },
								r = { "<cmd>Octo label add revisions\\ requested<cr>", "Revisions Requested" },
							},
							r = {
								name = "Removre Label",
								d = { "<cmd>Octo label remove ready\\ to\\ merge<cr>", "Ready to Merge" },
								r = { "<cmd>Octo label remove revisions\\ requested<cr>", "Revisions Requested" },
								R = { "<cmd>Octo label remove ready\\ for\\ review<cr>", "Ready for Review" },
							},
							s = { "<cmd>Octo review start<cr>", "Start Review" },
							d = { "<cmd>Octo review submit<cr>", "Submit Review" },
							c = { "<cmd>Octo review resume<cr>", "Continue Review" },
							t = { "<cmd>Octo review discard<cr>", "Discard Review" },
							C = { "<cmd>Octo review comments<cr>", "View Pending Comments" },
						},
						c = {
							name = "Comment",
							a = { "<cmd>Octo comment add<cr>", "Add" },
							d = { "<cmd>Octo comment delete<cr>", "Delete" },
						},
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
						a = { "<cmd>Octo actions<cr>", "Actions" },
						s = { "<cmd>Octo search<cr>", "Search" },
						l = { "<cmd>Octo pr list labels=ready\\ for\\ review<cr>", "List 'Ready for Review'" },
					},
				}

				wk.register(mappings, WKOpts)
			end
		end,
	})
end

return module
