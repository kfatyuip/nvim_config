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

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})

local flutter_path = os.getenv("FLUTTER_ROOT") and (os.getenv("FLUTTER_ROOT") .. "/bin/flutter")
  or "/opt/flutter/bin/flutter"
require("flutter-tools").setup({ flutter_path = flutter_path })

require("crates").setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
  popup = {
    autofocus = true,
    border = "rounded",
  },
})

require("fidget").setup()

require("hlchunk").setup({
  chunk = {
    enable = true,
    use_treesitter = true,
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = ">",
    },
    style = "#806d9c",
  },
  indent = {
    enable = true,
  },
})
