FormattersByFiletype = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	css = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	graphql = { "prettier" },
	lua = { "stylua" },
	python = { "black" },
	php = { "phpcbf" },
	ruby = { "rubocop" },
}

Formatters = {}
for _, v in pairs(FormattersByFiletype) do
	local formatter = v[1]
	if not Formatters[formatter] then
		Formatters[formatter] = formatter
	end
end

local module = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = FormattersByFiletype,
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})
	end,
}

return module
