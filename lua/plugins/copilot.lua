-- GitHub Copilot as an nvim-cmp source. Disabled at startup; toggle with
-- <leader>ct or :CopilotToggle. Auth once per machine with :Copilot auth.
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot", "CopilotToggle" },
    event = "InsertEnter",
    keys = {
      { "<leader>ct", "<cmd>CopilotToggle<cr>", desc = "Toggle Copilot completion" },
    },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      vim.api.nvim_create_user_command("CopilotToggle", function()
        if require("copilot.client").is_disabled() then
          require("copilot.command").enable()
          vim.notify("Copilot enabled", vim.log.levels.INFO)
        else
          require("copilot.command").disable()
          vim.notify("Copilot disabled", vim.log.levels.INFO)
        end
      end, { desc = "Toggle Copilot completion" })
      -- Start disabled; note `:Copilot toggle` cannot re-enable after disable(),
      -- so the command above uses explicit enable()/disable() instead.
      require("copilot.command").disable()
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
