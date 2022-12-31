-- Assigning a table to local variable opts
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Remapping Leader Key
keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nvim-Tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Buffer/Window Switching
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Continously select visual line
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Vim undo
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
