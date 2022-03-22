-- Defining alias for vim.opt.
local opt = vim.opt

-- correctly set temrinal colors
vim.o.termguicolors = true

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

-- keep multple buffers open
opt.hidden = true

-- enable mouse interaction
opt.mouse = "a"

opt.pumheight = 10

-- highlight text after yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Search", timeout=200}
  augroup END
]])
