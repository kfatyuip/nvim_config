require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]],
  shell = vim.o.shell,
  direction = "horizontal",
  hide_numbers = true,
  insert_mappings = true,
  close_on_exit = true,
  persist_size = true,
  shade_filetypes = {},
  shade_terminals = true,
  shade_factor = 2,
  start_in_insert = true,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
local python = Terminal:new({ cmd = "python", direction = "float", hidden = true })
local htop = Terminal:new({ cmd = "htop", direction = "float", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

function _python_toggle()
  python:toggle()
end

function _htop_toggle()
  htop:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>py", "<cmd>lua _python_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>lua _htop_toggle()<CR>", { noremap = true, silent = true })
