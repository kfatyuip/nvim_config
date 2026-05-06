return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.config")

      config.setup({
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
    end,
  },
}
