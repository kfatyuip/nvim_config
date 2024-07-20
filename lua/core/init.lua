vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4

vim.opt.guifont = "JetBrainsMono Nerd Font:h10"
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.wo.number = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                sort = {
                    sorter = "case_sensitive",
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            ensure_installed = {
                "lua_ls",
                "clangd",
                "taplo",
                "pyright",
                "zk",
                "jsonls",
                "html",
                "eslint",
                "rust-analyzer",
            }
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
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                },
                sections = {
                    lualine_c = {
                        function()
                            return require("lsp-progress").progress()
                        end,
                    },
                },
            })
        end,
    },
    {
        "linrongbin16/lsp-progress.nvim",
        config = function()
            require("lsp-progress").setup()
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = {
                        "prettierd",
                        "prettier",
                        stop_after_first = true,
                    },
                },
            })
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
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
    "folke/tokyonight.nvim",
})

require("core.keymaps")

vim.cmd([[colorscheme tokyonight]])
