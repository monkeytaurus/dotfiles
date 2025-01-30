local builtin_status, builtin = pcall(require, "telescope.builtin")

if not builtin_status then
	return
end

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find	, {})



require('telescope').load_extension('fzf')

