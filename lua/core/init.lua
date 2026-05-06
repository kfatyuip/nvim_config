vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.guifont = "JetBrainsMono Nerd Font:h10"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.number = true
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
require("core.autocmd")

require("vim._core.ui2").enable({ enable = true })
