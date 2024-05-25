local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', {['branch'] =  'master', ['do'] = 'npm ci'})
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })
Plug('junegunn/fzf.vim')
Plug('folke/tokyonight.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-neo-tree/neo-tree.nvim', {['branch'] = 'v3.x', ['requires'] = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}})

vim.call('plug#end')

require('options/cocnvim')
require('option')

vim.cmd[[colorscheme tokyonight-storm]]
