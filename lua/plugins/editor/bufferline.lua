return {
  "romgrk/barbar.nvim",
  dependencies = {
    { "lewis6991/gitsigns.nvim", keys = { { "<leader>gs", "<cmd>Gitsigns<cr>" } } },
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = true
  end,
}
