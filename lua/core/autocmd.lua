local group = vim.api.nvim_create_augroup("UserCore", { clear = true })

local warned_parsers = {}

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "*" },
  callback = function(ev)
    if ev.buf ~= vim.api.nvim_get_current_buf() or vim.bo[ev.buf].buftype ~= "" then
      return
    end
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if not lang then
      return
    end
    if not pcall(vim.treesitter.start, ev.buf) then
      local ok_parser = pcall(vim.treesitter.language.inspect, lang)
      if not ok_parser and not warned_parsers[lang] then
        warned_parsers[lang] = true
        vim.schedule(function()
          vim.notify(
            ("No treesitter parser for %q — install with `:TSInstall %s`"):format(vim.bo[ev.buf].filetype, lang),
            vim.log.levels.WARN
          )
        end)
      end
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
