vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local home = vim.uv.os_getenv("HOME")
    if not home then
      return
    end
    local exrc_path = vim.fs.normalize(home .. "/.nvimexrc")
    local current_dir = vim.uv.cwd()
    if not current_dir then
      return
    end
    local resolved_current = vim.fn.resolve(current_dir):gsub("/+$", "")
    local ok, lines = pcall(vim.fn.readfile, exrc_path)
    if not ok then
      if not (vim.uv or vim.loop).fs_stat(exrc_path) then
        local f = io.open(exrc_path, "w")
        if f then
          f:close()
        end
      end
      return
    end
    for _, line in ipairs(lines) do
      local path = line:match("^%s*(.-)%s*$")
      if path ~= "" then
        path = path:gsub("^~", home)
        local resolved_path = vim.fn.resolve(path):gsub("/+$", "")
        if resolved_current == resolved_path then
          vim.schedule(function()
            vim.cmd("Doexrc")
          end)
          break
        end
      end
    end
  end,
})
