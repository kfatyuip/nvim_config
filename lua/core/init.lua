vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4

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
  "williamboman/mason.nvim",
  "linrongbin16/lsp-progress.nvim",
  "stevearc/conform.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "lervag/vimtex",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = true,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    style = "storm",
    terminal_colors = true,
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
  },
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
      vim.g.tex_flavor = "latex"
    end,
  },
  "j-hui/fidget.nvim",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  "github/copilot.vim",
})

require("core.keymaps")
require("core.cmd")

require("plugins.tree")
require("plugins.cmp")
require("plugins.term")
require("plugins.treesitter")
require("plugins.statusline")
require("plugins.lsp")
require("plugins.dap")

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local home = os.getenv("HOME")
    local exrc_path = home .. "/.nvimexrc"
    local current_dir = vim.fn.getcwd()

    local file = io.open(exrc_path, "r")
    if file then
      for line in file:lines() do
        local path = line:match("^%s*(.-)%s*$")
        if path ~= "" then
          path = path:gsub("^~", home)
          path = vim.fn.resolve(path):gsub("/+$", "")
          local resolved_current = vim.fn.resolve(current_dir):gsub("/+$", "")

          if resolved_current == path then
            vim.cmd("Doexrc")
            break
          end
        end
      end
      file:close()
    end
  end,
})

vim.lsp.inlay_hint.enable(true)
