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

_G._lazygit_toggle = function()
  lazygit:toggle()
end

_G._python_toggle = function()
  python:toggle()
end

_G._htop_toggle = function()
  htop:toggle()
end
