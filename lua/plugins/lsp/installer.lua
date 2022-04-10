local lsp_installer_servers = require("nvim-lsp-installer.servers")

local module = {}

function module.setup(servers, options)
	for server_name, _ in pairs(servers) do
		local server_available, server = lsp_installer_servers.get_server(server_name)

		if server_available then
			server:on_ready(function()
				local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

				if server.name == "rust_analyzer" then
					require("rust-tools").setup({
						server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
					})
					server:attach_buffers()
				else
					server:setup(opts)
				end
			end)

			if not server:is_installed() then
				server:install()
			end
		else
			print("error in:", server.name)
		end
	end
end

return module
