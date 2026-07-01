local opencode_cmd = "opencode --port"

local opencode_term = nil
local function get_term()
  if not opencode_term then
    opencode_term = require("toggleterm.terminal").Terminal:new({
      cmd = opencode_cmd,
      direction = "vertical",
      hidden = true,
      start_in_insert = false,
      close_on_exit = true,
      on_open = function()
        vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.5))
      end,
    })
  end
  return opencode_term
end

return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  keys = {
    {
      "<C-a>",
      mode = { "n", "x" },
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      desc = "Ask opencode…",
    },
    {
      "<C-x>",
      mode = { "n", "x" },
      function()
        require("opencode").select()
      end,
      desc = "Select opencode…",
    },
    {
      "<C-.>",
      mode = { "n", "t" },
      function()
        get_term():toggle()
      end,
      desc = "Toggle opencode",
    },
    {
      "go",
      mode = { "n", "x" },
      function()
        return require("opencode").operator("@this ")
      end,
      desc = "Add range to opencode",
      expr = true,
    },
    {
      "goo",
      mode = "n",
      function()
        return require("opencode").operator("@this ") .. "_"
      end,
      desc = "Add line to opencode",
      expr = true,
    },
    {
      "<S-C-u>",
      mode = "n",
      function()
        require("opencode").command("session.half.page.up")
      end,
      desc = "Scroll opencode up",
    },
    {
      "<S-C-d>",
      mode = "n",
      function()
        require("opencode").command("session.half.page.down")
      end,
      desc = "Scroll opencode down",
    },
  },
  config = function()
    vim.g.opencode_opts = {
      server = {
        start = function()
          get_term():open()
        end,
      },
    }

    vim.o.autoread = true
  end,
}
