vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.guifont = "JetBrainsMono Nerd Font:h10"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.wo.number = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.o.exrc = true
vim.o.secure = true

vim.g.nvim_tree_respect_buf_cwd = 1

if vim.g.neovide then
  vim.g.neovide_opacity = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_floating_blur = 0.8
  vim.g.neovide_window_blurred = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.editor" },
  { import = "plugins.lsp" },
  { import = "plugins.ui" },
  { import = "plugins" },
})

require("core.keymaps")
require("core.cmd")

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local home = vim.uv.os_getenv("HOME")
    if not home then
      return
    end

    local exrc_path = home .. "/.nvimexrc"
    local current_dir = vim.fn.getcwd()
    local resolved_current = vim.fn.resolve(current_dir):gsub("/+$", "")

    if vim.fn.filereadable(exrc_path) == 0 then
      io.open(exrc_path, "w"):close()
      return
    end

    local lines = vim.fn.readfile(exrc_path, "", 1000)
    if vim.v.errno then
      return
    end

    for _, line in ipairs(lines) do
      local path = line:match("^%s*(.-)%s*$")
      if path ~= "" then
        path = path:gsub("^~", home)
        local resolved_path = vim.fn.resolve(path):gsub("/+$", "")
        if resolved_current == resolved_path then
          vim.cmd("Doexrc")
          break
        end
      end
    end
  end,
})

vim.lsp.inlay_hint.enable(true)
