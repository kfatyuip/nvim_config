local map = vim.keymap.set

map('n', '<leader><leader>', ':Neotree reveal<CR>', {})
map('n', '<leader>g', ':Neotree float git_status<CR>', {})

map('n', '<leader>l', ':Vista<CR>')

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})
map('n', '<leader>fj', builtin.jumplist, {})

map('n', 'gb', ':BufferLinePick<CR>', {})
map('n', 'gD', ':BufferLinePickClose<CR>', {})

map('n', '<leader>co', ':cd ~/.config/nvim<CR>', {})
