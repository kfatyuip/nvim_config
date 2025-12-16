local cmd = vim.api.nvim_create_user_command

cmd("Config", function()
  vim.cmd("cd " .. vim.fn.stdpath("config"))
  vim.cmd("Doexrc")
end, { desc = "Change pwd to neovim config directory" })

cmd("InlayHintToggle", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "InlayHint toggle for lsp server" })

cmd("Doexrc", function()
  local files = { ".nvim.lua", ".nvimrc", ".exrc" }
  for _, f in ipairs(files) do
    if vim.fn.filereadable(f) == 1 then
      local ok, err = pcall(vim.cmd.source, f)
      if not ok then
        vim.notify("Failed to source " .. f .. ": " .. err, vim.log.levels.ERROR)
      end
      break
    end
  end
end, { desc = "Load local config files" })

cmd("ConformConfigClear", function()
  clear_conform_config()
  vim.notify("Conform config cleared", vim.log.levels.INFO)
end, { desc = "Clear conform.nvim config" })

cmd("ConformConfigReset", function()
  reset_conform_config()
  vim.notify("Conform config reset", vim.log.levels.INFO)
end, { desc = "Reset conform.nvim config" })
