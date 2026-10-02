local group = vim.api.nvim_create_augroup("UserCore", { clear = true })

local exrc_dirs = nil
local exrc_mtime = nil

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

local warned_lang = {}

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "*" },
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if not lang then
      return
    end
    local ok, err = pcall(vim.treesitter.start, ev.buf)
    if ok or warned_lang[lang] then
      return
    end

    warned_lang[lang] = true

    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(ev.buf) or vim.bo[ev.buf].buftype ~= "" then
        return
      end
      vim.notify(
        ("treesitter: no parser for %s (%s)"):format(lang, tostring(err):gsub("^.*:%d+: ", "")),
        vim.log.levels.WARN
      )
    end)
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

    local resolved_current = vim.fn.resolve(vim.v.event and vim.v.event.cwd or vim.uv.cwd() or "")
    resolved_current = resolved_current:gsub("/+$", "")
    if resolved_current == "" then
      return
    end

    local exrc_path = vim.fs.normalize(home .. "/.nvimexrc")
    local stat = vim.uv.fs_stat(exrc_path)
    if not stat then
      local f = io.open(exrc_path, "w")
      if f then
        f:close()
      end
    end
    local mtime = stat and (stat.mtime.sec .. ":" .. stat.mtime.nsec) or "none"
    if exrc_dirs == nil or exrc_mtime ~= mtime then
      exrc_mtime = mtime
      exrc_dirs = {}
      for _, line in ipairs(stat and vim.fn.readfile(exrc_path) or {}) do
        local path = line:match("^%s*(.-)%s*$")
        if path and path ~= "" then
          path = path:gsub("^~", home)
          local resolved = vim.fn.resolve(path)
          resolved = resolved:gsub("/+$", "")
          table.insert(exrc_dirs, resolved)
        end
      end
    end
    for _, dir in ipairs(exrc_dirs) do
      if resolved_current == dir then
        vim.schedule(function()
          vim.cmd("Doexrc")
        end)
        break
      end
    end
  end,
})
