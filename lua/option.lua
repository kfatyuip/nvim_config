local map = vim.keymap.set

vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4

vim.opt.guifont = "JetBrainsMono Nerd Font:h10"
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.wo.number = true

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})

local bufferline = require('bufferline')
map('n', 'gb', ':BufferLinePick<CR>', {})
map('n', 'gD', ':BufferLinePickClose<CR>', {})
