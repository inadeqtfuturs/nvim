LintersByFiletype = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	python = { "pylint" },
	["*"] = { "codespell" },
}

Linters = {}
for _, v in pairs(LintersByFiletype) do
	if not Linters[v] then
		table.insert(Linters, v)
	end
end

local module = {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		-- diagnostics
		local lint = require("lint")

		lint.linters_by_ft = LintersByFiletype

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
return module
