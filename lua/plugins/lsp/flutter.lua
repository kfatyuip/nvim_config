return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    keys = {
      { "<leader>ft", "<cmd>Telescope flutter commands<cr>", desc = "Flutter commands", silent = true },
    },
    config = function()
      local from_env = vim.env.FLUTTER_ROOT
      local flutter_path = (from_env and from_env ~= "" and from_env .. "/bin/flutter")
        or (vim.fn.exepath("flutter") ~= "" and vim.fn.exepath("flutter") or nil)
        or "/opt/flutter/bin/flutter"

      require("flutter-tools").setup({
        flutter_path = flutter_path,
      })
    end,
  },
}
