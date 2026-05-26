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
        require("opencode").toggle()
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
    vim.o.autoread = true
  end,
}
