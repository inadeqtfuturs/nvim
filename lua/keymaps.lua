-- remap leader to space
vim.g.mapleader = " "

-- split navigation
map("", "<S-h>", "<c-w>h")
map("", "<S-j>", "<c-w>j")
map("", "<S-k>", "<c-w>k")
map("", "<S-l>", "<c-w>l")

-- window navigation
map("", "<C-h>", "<C-w>h")
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")

-- Move current line / block with Alt-j/k a la vscode.
map("", "<A-j>", ":m .+1<CR>==")
map("", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv-gv")
map("v", "<A-k>", ":m '<-2<CR>gv-gv")

-- save
map("", "<C-s>", ":w<cr>")
