local cmd = vim.api.nvim_create_user_command

cmd(
  "Config", function()
    vim.cmd("cd " .. vim.fn.stdpath("config"))
    vim.cmd("Doexrc")
end,
  { desc = "change pwd to neovim config directory" }
)

cmd(
  "InlayHintToggle",
  "lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())",
  { desc = "inlay hint toggle for lsp server" }
)

cmd("Doexrc", function()
  local files = {".nvim.lua", ".nvimrc", ".exrc"}
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("source "..file)
      break
    end
  end
end, {desc = "Load local config files"})
