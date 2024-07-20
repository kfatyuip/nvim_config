local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "telescope find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "telescope live_grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "telescope buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "telescope help_tags" })

-- map("n", "<leader>ft", require("telescope").extensions.flutter.commands)
