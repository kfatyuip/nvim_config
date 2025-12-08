return {
  "saecki/crates.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "rust", "toml" },
  keys = {
    {
      "<leader>cv",
      function()
        require("crates").show_versions_popup()
      end,
      desc = "Crate Versions",
    },
    {
      "<leader>cf",
      function()
        require("crates").show_features_popup()
      end,
      desc = "Crate Features",
    },
    {
      "<leader>cd",
      function()
        require("crates").show_dependencies_popup()
      end,
      desc = "Crate Dependencies",
    },
    {
      "<leader>cu",
      function()
        require("crates").update_crate()
      end,
      desc = "Update Crate",
    },
    {
      "<leader>cU",
      function()
        require("crates").update_all_crates()
      end,
      desc = "Update All Crates",
    },
  },
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
    popup = {
      autofocus = true,
      border = "rounded",
    },
  },
}
