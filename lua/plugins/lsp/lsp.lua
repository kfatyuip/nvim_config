return {
  { "williamboman/mason.nvim", config = true },
  { "j-hui/fidget.nvim", config = true },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = "#806d9c",
      },
      indent = {
        enable = true,
      },
    },
  },
}
