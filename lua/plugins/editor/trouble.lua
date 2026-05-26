return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = true,
  keys = {
    { "<leader>ds", "<cmd>Trouble diagnostics<cr>", desc = "Diagnostics", silent = true },
    { "<leader>fs", "<cmd>Trouble symbols<cr>", desc = "Symbols", silent = true },
    { "gd", "<cmd>Trouble lsp_definitions<cr>", desc = "Go to definition", silent = true },
    { "gr", "<cmd>Trouble lsp_references<cr>", desc = "Go to references", silent = true },
    { "<leader>fS", "<cmd>Trouble lsp_document_symbols<cr>", desc = "Document symbols", silent = true },
  },
}
