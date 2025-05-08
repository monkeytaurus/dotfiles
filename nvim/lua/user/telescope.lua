local builtin_status, builtin = pcall(require, "telescope.builtin")

if not builtin_status then
  return
end

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<space>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"


--[[Search for a file starting at my home directory.  ]]
vim.keymap.set('n', '<leader>F', function()
  require('telescope.builtin').find_files({
    prompt_title = "Global File Search",
    cwd = "~",     -- root of the filesystem
    hidden = true, -- include hidden files
    follow = true, -- follow symlinks
  })
end, { desc = "Find files (global)" })
