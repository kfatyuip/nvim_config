require("nvim-tree").setup({
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
})
