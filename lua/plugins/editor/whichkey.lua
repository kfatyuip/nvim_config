return {
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
  config = function()
    local wk = require("which-key")
    wk.setup()
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>e", group = "explorer" },
      { "<leader>f", group = "find/format" },
      { "<leader>g", group = "git" },
      { "<leader>j", group = "jump" },
      { "<leader>l", group = "lazy/terminal" },
      { "<leader>m", group = "marks" },
      { "<leader>r", group = "rename" },
      { "<leader>s", group = "search/symbols" },
      { "<leader>t", group = "tab/telescope" },
      { "<leader>t d", group = "dap (telescope)" },
    })
  end,
}
