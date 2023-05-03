module = {
	"olimorris/persisted.nvim",
	priority = 999,
	config = function()
		require("persisted").setup({
			autoload = true,
		})

		--[[ vim.api.nvim_create_autocmd({ "User" }, { ]]
		--[[ 	pattern = "PersistedSavePre", ]]
		--[[ 	group = vim.api.nvim_create_augroup("PersistedHooks", {}), ]]
		--[[ 	callback = function() ]]
		--[[ 		pcall(vim.cmd, "NvimTreeClose") ]]
		--[[ 	end, ]]
		--[[ }) ]]
	end,
}

return module
