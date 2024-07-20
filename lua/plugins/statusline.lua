require("lualine").setup({
  options = {
    theme = "tokyonight",
  },
  sections = {
    lualine_c = {
      "filename",
      function()
        return require("lsp-progress").progress()
      end,
    },
  },
})
