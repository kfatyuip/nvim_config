return {
  "folke/tokyonight.nvim",
  lazy = false,
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
