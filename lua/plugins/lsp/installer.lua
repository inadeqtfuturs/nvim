local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

local module = {}

function module.setup(servers, options)
	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = false,
	})

	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		local opts = vim.tbl_deep_extend("force", options, servers[server] or {})
		lspconfig[server].setup(opts)
	end
end

return module
