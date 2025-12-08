return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sync_root_with_cwd = true,
      sort = {
        sorter = "case_sensitive",
      },
      filters = {
        dotfiles = true,
      },
      update_focused_file = {
        enable = true,
      },
    },
  },
  { "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false, config = true },
}
