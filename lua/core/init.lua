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
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.exrc = true
vim.o.autoread = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local has_cmd = function(name)
  return vim.fn.executable(name) == 1
end
local nvr_cmd
if has_cmd("nvr") then
  nvr_cmd = "nvr"
elseif has_cmd("uv") then
  nvr_cmd = "uv tool run --from neovim-remote nvr"
end
if nvr_cmd then
  local nvr = nvr_cmd .. " -cc split --remote-wait"
  -- vim.env.* only affects this Neovim and its children, not the parent shell's
  -- $EDITOR. Programs taking only the first token would see "uv" as the editor in
  -- the fallback branch; on this machine nvr is on PATH so the first branch runs.
  -- Prefer `uv tool install neovim-remote` to keep nvr available without uv.
  vim.env.VISUAL = nvr
  vim.env.EDITOR = nvr
end

vim.g.nvim_tree_respect_buf_cwd = 1

if vim.g.neovide then
  vim.g.neovide_opacity = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_floating_blur = 0.8
  vim.g.neovide_window_blurred = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 or not vim.uv.fs_stat(lazypath) then
    vim.notify("Failed to bootstrap lazy.nvim at " .. lazypath, vim.log.levels.ERROR)
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.editor" },
    { import = "plugins.lsp" },
    { import = "plugins.ui" },
    { import = "plugins" },
  },
  change_detection = { notify = false },
})

require("core.keymaps")
require("core.cmd")
require("core.autocmd")

-- vim._core.ui2 is an internal Neovim module (0.12+).
local ui2_ok, ui2 = pcall(require, "vim._core.ui2")
if ui2_ok then
  pcall(ui2.enable, { enable = true })
end
