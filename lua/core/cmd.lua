local cmd = vim.api.nvim_create_user_command

cmd("Config", "cd " .. vim.fn.stdpath("config"), { desc = "change pwd to neovim config directory" })

cmd(
  "InlayHintToggle",
  "lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())",
  { desc = "inlay hint toggle for lsp server" }
)
