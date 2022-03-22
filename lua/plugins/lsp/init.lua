local module = {}


local function on_attach()
	require("plugins.lsp.keymaps").setup()
	require("plugins.lsp.highlighter").setup()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if package.loaded["cmp_nvim_lsp"] then
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
end

local opts = {
	on_attach = on_attach,
	capabilities = capabilities,
}

require("plugins.lsp.handlers").setup()

-- convert to
function module.init(use)
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/nvim-lsp-installer" },
			{ "ray-x/lsp_signature.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function()
      local servers = {
        jsonls = {},
        sumneko_lua = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        tsserver = {},
      }

			-- servers
			require("plugins.lsp.installer").setup(servers, opts)

			-- null-ls
			require("null-ls").setup({
				sources = {
					-- js
					require("null-ls").builtins.formatting.eslint_d,
					require("null-ls").builtins.diagnostics.eslint_d,
					require("null-ls").builtins.code_actions.eslint_d,

					-- lua
					require("null-ls").builtins.formatting.stylua,

					-- php
					require("null-ls").builtins.formatting.phpcbf,

					-- ruby
					require("null-ls").builtins.diagnostics.rubocop,
					require("null-ls").builtins.formatting.rubocop,
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	})
end

return module
