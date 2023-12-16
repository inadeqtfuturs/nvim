FormattersByFiletype = {
  javascript = { "prettier" },
  typescript = { "prettier" },
  javascriptreact = { "prettier" },
  typescriptreact = { "prettier" },
  svelte = { "prettier" },
  css = { "prettier" },
  html = { "prettier" },
  json = { "prettier" },
  yaml = { "prettier" },
  markdown = { "prettier" },
  graphql = { "prettier" },
  lua = { "stylua" },
  python = { "isort", "black" },
  php = { "phpcbf" },
  ruby = { "rubocop" },
}

Formatters = {}
for _, v in pairs(FormattersByFiletype) do
	if not Formatters[v] then
		table.insert(Formatters, v)
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
