vim.cmd [[packadd packer.nvim]]

require('plugins')
require('pTelescope')
require('lspSetup')
--
require('Settings')
require('pTreesitter')
require('pCmp')
require('pMason')
--require('javalsp')

require('startup')
--require('cmake')
require('msbuild')
require("oil").setup()
require('pOil')
require('pRunner')
require('GitConfiguration')

vim.api.nvim_set_keymap('n', 'cd', [[:e . <CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>s', ':set list! <CR>', {})

vim.cmd([[:set listchars=tab:~~#,trail:*,eol:·,space:-,multispace:--+]])
vim.cmd([[set autoindent]])
vim.cmd([[:set expandtab]])
vim.cmd([[set tabstop=4]])
vim.cmd([[set shiftwidth=4]])
vim.cmd([[:lua require('cmake')]])

