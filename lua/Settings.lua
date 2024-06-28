local global = vim.g
local o = vim.o

-- Leader key

vim.g.mapleader = " "
vim.g.mapelocalleader = " "
vim.cmd('set notimeout')
vim.cmd('set ttimeout')

-- Editor

--o.silent = true
o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"

-- Theam
--vim.cmd('colorscheme kanagwa')
vim.cmd("colorscheme carbonfox")

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n','<leader>ff',builtin.find_files)
vim.keymap.set('n','<leader>fg',builtin.live_grep)
vim.keymap.set('n','<leader>fb',builtin.buffers)
vim.keymap.set('n','<leader>fh',builtin.help_tags)
