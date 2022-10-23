-- Defining alias for vim.opt.
local opt = vim.opt

-- correctly set temrinal colors
vim.o.termguicolors = true
vim.opt.encoding = "utf-8"

-- timeout
opt.timeoutlen = 100

-- clipboard
vim.o.clipboard = "unnamed,unnamedplus"

-- undo handling
vim.o.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.o.undolevels = 1000
vim.o.undoreload = 10000

-- automatically read changes in files from outside of vim (git pull, etc.)
vim.o.autoread = true

-- show line numbers
vim.wo.number = true
opt.numberwidth = 4
opt.signcolumn = "yes"

-- wrap lines at convenient points
vim.wo.wrap = true
vim.wo.linebreak = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.cursorline = true
opt.scrolloff = 10

opt.showmode = false

-- keep multiple buffers open
opt.hidden = true

-- enable mouse interaction
opt.mouse = "a"

opt.pumheight = 10

-- highlight tesdfxt after yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Search", timeout=200}
  augroup END
]])

-- remap leader to space
vim.g.mapleader = " "

-- split navigation
map("", "<C-h>", "<c-w>h")
map("", "<C-j>", "<c-w>j")
map("", "<C-k>", "<c-w>k")
map("", "<C-l>", "<c-w>l")

-- save
map("", "<C-s>", ":w<cr>")
