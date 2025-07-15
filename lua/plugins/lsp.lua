local lspconfig = require("lspconfig")
local function setup_server(server)
  local config = {
    on_init = function(client)
      client.server_capabilities.workspace = { workspace_folders = true }
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
  local server_configs = {
    clangd = { root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git") },
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
          codeLens = { enable = true },
        },
      },
    },
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = os.getenv("checkOnSave") ~= nil,
          cargo = {
            buildScripts = { enable = os.getenv("buildScripts") ~= nil },
            allFeatures = os.getenv("allFeatures") ~= nil,
            loadOutDirsFromCheck = true,
          },
          procMacro = { enable = true },
          server = { extraEnv = { RUST_SRC_PATH = "/usr/lib/rustlib/src/rust/library" } },
        },
      },
    },
  }
  return vim.tbl_deep_extend("force", config, server_configs[server] or {})
end

for _, lsp in ipairs(require("mason-lspconfig").get_installed_servers()) do
  lspconfig[lsp].setup(setup_server(lsp))
end

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
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

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})

local flutter_path = os.getenv("FLUTTER_ROOT") and (os.getenv("FLUTTER_ROOT") .. "/bin/flutter")
  or "/opt/flutter/bin/flutter"
require("flutter-tools").setup({ flutter_path = flutter_path })
