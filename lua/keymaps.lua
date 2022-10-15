-- remap leader to space
vim.g.mapleader = " "

-- split navigation
map("", "<C-h>", "<c-w>h")
map("", "<C-j>", "<c-w>j")
map("", "<C-k>", "<c-w>k")
map("", "<C-l>", "<c-w>l")

-- window navigation
-- map("", "<M-h>", "<C-w>h")
-- map("", "<M-j>", "<C-w>j")
-- map("", "<M-k>", "<C-w>k")
-- map("", "<M-l>", "<C-w>l")

-- Move current line / block with Alt-j/k a la vscode.
map("", "<A-j>", ":m .+1<CR>==")
map("", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv-gv")
map("v", "<A-k>", ":m '<-2<CR>gv-gv")

-- save
map("", "<C-s>", ":w<cr>")
