return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    branch = "main",
    build = ":TSUpdate",
  },
}
