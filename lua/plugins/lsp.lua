local servers = require("mason-lspconfig").get_installed_servers()

local on_init = function(client)
  client.server_capabilities.workspace = {
    workspace_folders = true,
  }
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    -- on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

lspconfig.clangd.setup({
  on_init = on_init,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})

lspconfig.lua_ls.setup({
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      codeLens = {
        enable = true,
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      checkOnSave = os.getenv("checkOnSave") ~= nil,
      cargo = {
        buildScripts = {
          enable = os.getenv("buildScripts") ~= nil,
        },
        allFeatures = os.getenv("allFeatures") ~= nil,
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      server = {
        extraEnv = {
          RUST_SRC_PATH = "/usr/lib/rustlib/src/rust/library",
        },
      },
    },
  },
})

require("fidget").setup()

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--use-tabs", "--tab-width", vim.o.shiftwidth },
    },
  },
})

require("lsp-progress").setup()
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})

local flutter_path = "/opt/flutter/bin/flutter"
if os.getenv("FLUTTER_ROOT") ~= nil then
  flutter_path = os.getenv("FLUTTER_ROOT") .. "/bin/flutter"
end

require("flutter-tools").setup({
  flutter_path = flutter_path,
})
