require('runner').setup({
	precommand = '',
	use_preCommand = true,
})


vim.keymap.set('n','<leader>rr',":Runner<CR><CR>")
vim.keymap.set('n','<leader>ru',":RunnerSet<CR>")
vim.keymap.set('n','<leader>ri',":RunnerCreate<CR>")
vim.keymap.set('n','<leader>ro',":RunnerOptions<CR>")
