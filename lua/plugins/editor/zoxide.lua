return {
  "alfaix/nvim-zoxide",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Z", "Zt", "Zw" },
  opts = {
    define_commands = true,
    path = "zoxide",
  },
}
