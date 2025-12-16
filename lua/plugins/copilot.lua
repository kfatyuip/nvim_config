return {
  { "zbirenbaum/copilot.lua", config = true },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
