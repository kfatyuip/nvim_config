local treesitter = require("nvim-treesitter")
local configs = require("nvim-treesitter.configs")

configs.setup({
  highlight = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
