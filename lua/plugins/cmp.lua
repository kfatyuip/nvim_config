require("mason").setup()
local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("dart", { "flutter" })

local cmp_kinds = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

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
  formatting = {
    format = function(_, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s %s", cmp_kinds[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
      -- Source
      -- vim_item.menu = ({
      --   buffer = "[Buffer]",
      --   nvim_lsp = "[LSP]",
      --   luasnip = "[LuaSnip]",
      --   nvim_lua = "[Lua]",
      --   latex_symbols = "[LaTeX]",
      -- })[entry.source.name]
      return vim_item
    end,
  },

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
  view = {
    entries = { name = "wildmenu", separator = "|" },
  },
})
