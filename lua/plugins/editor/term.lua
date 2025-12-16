local terminals = {
  gi = { cmd = "lazygit", desc = "Toggle LazyGit" },
  py = { cmd = "python", desc = "Toggle Python REPL" },
  ht = { cmd = "htop", desc = "Toggle htop" },
  fl = { cmd = nil, desc = "Open a floating terminal" },
}

local keys = {}
for prefix, info in pairs(terminals) do
  table.insert(keys, {
    "<leader>" .. prefix,
    function()
      require("toggleterm.terminal").Terminal
        :new({
          cmd = info.cmd,
          direction = "float",
          hidden = true,
        })
        :toggle()
    end,
    desc = info.desc,
  })
end

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
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
    keys = keys,
  },
}
