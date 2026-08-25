local terminals = {
  lg = { cmd = "lazygit", desc = "Toggle LazyGit" },
  py = { cmd = "python", desc = "Toggle Python REPL" },
  ht = { cmd = "htop", desc = "Toggle htop" },
}

local keys = {
  { "<c-\\>", mode = { "n", "t", "i" }, desc = "Toggle terminal", silent = true },
  {
    "<c-|>",
    mode = { "n", "t", "i" },
    function()
      local Terminal = require("toggleterm.terminal").Terminal
      local vertical_term = Terminal:new({
        cmd = vim.o.shell,
        direction = "vertical",
        hidden = true,
      })
      vertical_term:toggle(vim.o.columns * 0.5)
    end,
    desc = "Toggle terminal vertical",
    silent = true,
  },
  { "<leader>fl", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal", silent = true },
  { "<C-w>", mode = "t", [[<C-\><C-n><C-w>]], silent = true },
}

for prefix, info in pairs(terminals) do
  table.insert(keys, {
    "<leader>" .. prefix,
    function()
      require("toggleterm.terminal").Terminal:new({ cmd = info.cmd, direction = "float", hidden = true }):toggle()
    end,
    desc = info.desc,
    silent = true,
  })
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = keys,
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
          end
        end,
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
    end,
  },
}
