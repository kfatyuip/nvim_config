return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      local flutter_path = vim.uv.os_getenv("FLUTTER_ROOT") and (vim.uv.os_getenv("FLUTTER_ROOT") .. "/bin/flutter")
        or vim.fn.exepath("flutter")
        or "/opt/flutter/bin/flutter"

      require("flutter-tools").setup({
        flutter_path = flutter_path,
      })
    end,
  },
}
