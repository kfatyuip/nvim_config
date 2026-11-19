local LspProgressStatusUpdated = "LspProgressStatusUpdated"

return {
  {
    "linrongbin16/lsp-progress.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { event = LspProgressStatusUpdated },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
        sections = {
          lualine_c = {
            "filename",
            function()
              return require("lsp-progress").progress()
            end,
          },
        },
      })

      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = LspProgressStatusUpdated,
        callback = require("lualine").refresh,
      })
    end,
  },
}
