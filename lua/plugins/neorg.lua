local module = {}

function module.init(use)
	use({
		"nvim-neorg/neorg",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.norg.concealer"] = {},
					["core.gtd.base"] = {
						config = {
							workspace = "todo",
						},
					},
					["core.norg.dirman"] = {
						config = {
							workspaces = {
								notes = "~/neorg/notes",
								todo = "~/neorg/todo",
							},
						},
					},
					["core.keybinds"] = {
						config = {
							-- default_keybinds = true,
							neorg_leader = "<Leader>o",
						},
					},
				},
			})

			-- keymaps
			local neorg_leader = "<Leader>" -- You may also want to set this to <Leader>o for "organization"

			-- Require the user callbacks module, which allows us to tap into the core of Neorg
			local neorg_callbacks = require("neorg.callbacks")

			-- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
			-- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
			-- needs to reevaluate all the bound keys is invoked
			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				-- Map all the below keybinds only when the "norg" mode is active
				keybinds.remap("norg", "n", "<C-s>", "<cmd>write<CR>")

				keybinds.map_event_to_mode("norg", {
					n = { -- Bind keys in normal mode

						-- Keys for managing TODO items and setting their states
						{ "gtd", "core.norg.qol.todo_items.todo.task_done" },
						{ "gtu", "core.norg.qol.todo_items.todo.task_undone" },
						{ "gtp", "core.norg.qol.todo_items.todo.task_pending" },
						{ "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },
					},
				}, { silent = true, noremap = true })
			end)
		end,
	})
end

return module
