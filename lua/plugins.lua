-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	local configs = {
		-- theme
		"substrata",

		-- dashboard
		"dashboard",

		-- treesitter
		"treesitter",

		-- finder
		"telescope",

		-- file tree
		"nvimtree",

		-- autocomplete
		"cmp",

		-- formatting // linting
		"null_ls_config",

		-- lsp
		"lsp",

		-- ide
		"barbar",
		"indent_blankline",
		"autopairs",
		"autotag",
		"comments",
		"cool",
		"lightspeed",

		-- terminal
		"toggleterm",

		-- git
		"gitsigns",
		"blamer",
		"octo",

		-- which key
		"which_key",

		-- lualine
		"lualine",

		-- lush
		"lush",
	}

	for i, name in ipairs(configs) do
		require("plugins/" .. name).init(use)
	end

	-- auto compile packer when config is changed
	vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
end)
