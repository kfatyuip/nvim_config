require("mason").setup()
local cmp = require("cmp")

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gd",
    "<Cmd>lua vim.lsp.buf.definition()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gD",
    "<Cmd>Telescope lsp_definitions<CR>",
    opts
  )
end

local on_init = function(client)
  client.server_capabilities.workspace = {
    workspace_folders = true,
  }
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})
