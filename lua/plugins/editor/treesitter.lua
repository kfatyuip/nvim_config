return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate" },
    branch = "main",
    build = ":TSUpdate",
  },
}
