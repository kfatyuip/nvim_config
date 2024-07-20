require("lualine").setup({
  options = {
    theme = "tokyonight",
  },
  sections = {
    lualine_c = {
      function()
        return require("lsp-progress").progress()
      end,
    },
  },
})
