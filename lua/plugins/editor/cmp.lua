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

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("dart", { "flutter" })
      luasnip.config.setup({ history = true, delete_check_events = "TextChanged" })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
          format = function(entry, vim_item)
            local icon = cmp_kinds[vim_item.kind] or ""
            vim_item.kind = string.format("%s %s", icon, vim_item.kind)

            if entry.source.name == "copilot" then
              vim_item.kind = " Copilot"
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              copilot = "[Copilot]",
              buffer = "[Buf]",
              path = "[Path]",
              vimtex = "[Tex]",
              crates = "[Crate]",
            })[entry.source.name] or string.format("[%s]", entry.source.name)

            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "copilot", priority = 500 },
        }, {
          { name = "path", priority = 250 },
          { name = "vimtex", priority = 250 },
          { name = "crates", priority = 250 },
          { name = "buffer", priority = 100, keyword_length = 3 },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
        view = { entries = { name = "wildmenu", separator = "|" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}
