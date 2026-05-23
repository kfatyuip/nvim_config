return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd([[colorscheme tokyonight]])
  end,
}
