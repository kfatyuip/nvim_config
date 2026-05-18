local terminals = {
  lg = { cmd = "lazygit", desc = "Toggle LazyGit" },
  py = { cmd = "python", desc = "Toggle Python REPL" },
  ht = { cmd = "htop", desc = "Toggle htop" },
}

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        shell = vim.o.shell,
        direction = "horizontal",
        hide_numbers = true,
        insert_mappings = true,
        close_on_exit = true,
        persist_size = true,
        shade_filetypes = {},
        shade_terminals = true,
        shade_factor = 2,
        start_in_insert = true,
        persist_mode = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      vim.keymap.set("n", "<leader>fl", "<cmd>ToggleTerm direction=float<cr>")
      for prefix, info in pairs(terminals) do
        vim.keymap.set("n", "<leader>" .. prefix, function()
          require("toggleterm.terminal").Terminal
            :new({
              cmd = info.cmd,
              direction = "float",
              hidden = true,
            })
            :toggle()
        end, { desc = info.desc })
      end
    end,
  },
}
