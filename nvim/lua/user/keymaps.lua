-- Assigning a table to local variable opts
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
--
-- Remapping Leader Key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)



-- keymap("n", "<leader>e", "<C-w>l", opts) (Telescope Hotkey)

keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Continously select visual line
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
