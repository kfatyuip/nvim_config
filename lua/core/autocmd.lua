local group = vim.api.nvim_create_augroup("UserCore", { clear = true })

local function fcitx5_remote(args)
  if vim.fn.executable("fcitx5-remote") ~= 1 then
    return nil
  end
  local obj = vim.system(vim.list_extend({ "fcitx5-remote" }, args), { text = true }):wait()
  return (obj.stdout or ""):match("%d+")
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = group,
  callback = function()
    local state = fcitx5_remote({})
    if not state then
      return
    end
    vim.g.fcitx5_cmdline_was_active = state == "2"
    if state == "2" then
      fcitx5_remote({ "-c" })
    end
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = group,
  callback = function()
    if vim.g.fcitx5_cmdline_was_active then
      fcitx5_remote({ "-o" })
      vim.g.fcitx5_cmdline_was_active = false
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "*" },
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang then
      pcall(vim.treesitter.start, ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  group = group,
  pattern = "*",
  callback = function()
    local home = vim.uv.os_getenv("HOME")
    if not home then
      return
    end
    local exrc_path = vim.fs.normalize(home .. "/.nvimexrc")
    local event = vim.v.event
    local current_dir = event and event.cwd or vim.uv.cwd()
    if not current_dir then
      return
    end
    local resolved_current = vim.fn.resolve(current_dir):gsub("/+$", "")
    local ok, lines = pcall(vim.fn.readfile, exrc_path)
    if not ok then
      if not vim.uv.fs_stat(exrc_path) then
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
