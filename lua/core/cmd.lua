local cmd = vim.api.nvim_create_user_command

cmd("Config", function()
  vim.fn.chdir(vim.fn.stdpath("config"), "tabpage")
  vim.cmd("Doexrc")
end, { desc = "Change pwd(tabpage) to neovim config directory" })

cmd("InlayHintToggle", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "InlayHint toggle for lsp server" })

cmd("Doexrc", function()
  local files = { ".nvim.lua", ".nvimrc", ".exrc" }
  for _, f in ipairs(files) do
    if vim.fn.filereadable(f) == 1 then
      if vim.secure.read(f) == nil then
        vim.notify(("Doexrc: '%s' is not trusted; run :trust %s to allow it"):format(f, f), vim.log.levels.WARN)
        return
      end
      local ok, err = pcall(vim.cmd.source, f)
      if not ok then
        vim.notify("Config Error (" .. f .. "): " .. err, vim.log.levels.WARN)
      end
      break
    end
  end
end, { desc = "Load local config files" })

cmd("ConformConfigClear", function()
  local ok, fmt = pcall(require, "plugins.editor.fmt")
  if not ok then
    vim.notify("Conform config module unavailable", vim.log.levels.WARN)
    return
  end
  fmt.clear_conform_config()
  vim.notify("Conform config cleared", vim.log.levels.INFO)
end, { desc = "Clear conform.nvim config" })

cmd("ConformConfigReset", function()
  local ok, fmt = pcall(require, "plugins.editor.fmt")
  if not ok then
    vim.notify("Conform config module unavailable", vim.log.levels.WARN)
    return
  end
  fmt.reset_conform_config()
  vim.notify("Conform config reset", vim.log.levels.INFO)
end, { desc = "Reset conform.nvim config" })
