return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
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
    end,
  },
}
