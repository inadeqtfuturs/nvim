local module = {}

function module.init(use)
	use({
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup({
				org_agenda_files = { "~/org/todo/*" },
				org_default_notes_file = "~/org/notes.org",
			})

			require("orgmode").setup_ts_grammar()
		end,
	})
end

return module
