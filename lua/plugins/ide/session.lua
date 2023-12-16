module = {
	"olimorris/persisted.nvim",
	priority = 999,
	config = function()
		require("persisted").setup({
			autoload = true,
		})

		-- close nvim tree before saving session
		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "PersistedSavePre",
			group = vim.api.nvim_create_augroup("PersistedHooks", {}),
			callback = function()
				pcall(vim.cmd, "NvimTreeClose")
				pcall(vim.cmd, "TroubleClose")
			end,
		})
	end,
}

return module
