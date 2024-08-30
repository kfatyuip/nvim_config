local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "lua_ls",
  "clangd",
  "taplo",
  "pyright",
  "zk",
  "jsonls",
  "html",
  "eslint",
  "mesonlsp",
}

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<cr>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gD",
    "<cmd>Telescope lsp_definitions<cr>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gr",
    "<cmd>lua vim.lsp.buf.references()<cr>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gR",
    "<cmd>Telescope lsp_references<cr>",
    opts
  )
end

local on_init = function(client)
  client.server_capabilities.workspace = {
    workspace_folders = true,
  }
end

local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      diagostics = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
        allFeatures = true,
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
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = {
      "prettierd",
      "prettier",
      stop_after_first = true,
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
