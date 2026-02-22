return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  style = "storm",
  terminal_colors = true,
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  config = function()
    vim.cmd([[colorscheme tokyonight]])
  end,
}
