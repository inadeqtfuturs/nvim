local fn = vim.fn

local lazy_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazy_path,
	})
end
vim.opt.rtp:prepend(lazy_path)

local plugins = {}
local folders = {
	"core",
	"lsp",
	"ui",
	"git",
	"ide",
}

-- in each plugin folder, find the `init.lua` and load
-- each plugin returned from the module
for _, folder in ipairs(folders) do
	local init_map = require("plugins." .. folder .. ".init")
	for _, file in ipairs(init_map) do
		table.insert(plugins, require("plugins." .. folder .. "." .. file))
	end
end

require("lazy").setup(plugins)
