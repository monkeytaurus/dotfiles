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

-- Unbind Exit
keymap("n", "<C-z>", "<Nop>", opts)

-- Delete highlighted word into void register.
--Deletes the word under the cursor with changing the unnamed register using blackhole register
--Paste word over another word without losing it in the paste register. Essentially high and yank first and then highlight over text to past over word. 
keymap("x", "<leader>p", '"_dP', opts)

-- Yank to system clipboard
keymap("n", "<leader>y", '"+y', opts)

-- Yanks to system clipboard while in visual mode
keymap("v", "<leader>y", '" +y ', opts)

-- Yanks whole line into System clipboard
keymap("n", "<leader>Y", '"+Y', opts)

-- Deleting to blackhole register
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)



-- Vim Maximizer
keymap("n", "<C-w>m", ":MaximizerToggle<CR>", opts)

-- Allow search terms to stay in the middle 
keymap ("n", "n", "nzzzv", opts)
keymap ("n", "N", "Nzzzv", opts)

