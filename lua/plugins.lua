-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	require("core").init(use)
	require("lsp").init(use)
	require("ui").init(use)
	require("git").init(use)
	require("ide").init(use)
	require("api").init()

	-- auto compile packer when config is changed
	vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
end)
