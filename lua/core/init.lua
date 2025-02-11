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

vim.g.nvim_tree_respect_buf_cwd = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
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
    config = function() end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.tree")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.lsp")
    end,
  },
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
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.statusline")
    end,
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
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
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
    config = function()
      require("plugins.ts")
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          style = "#806d9c",
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.term")
    end,
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
    config = function()
      require("plugins.dap")
    end,
  },
  "j-hui/fidget.nvim",
  "github/copilot.vim",
})

require("core.keymaps")
require("core.cmd")

-- if vim.g.neovide then
--   vim.g.neovide_transparency = 0.8
--   vim.g.transparency = 0.8
--   vim.g.neovide_floating_blur = 0.8
--   vim.g.neovide_window_blurred = true
-- end
