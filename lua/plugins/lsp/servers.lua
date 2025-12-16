return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local server_configs = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
              codeLens = { enable = true },
            },
          },
          capabilities = capabilities,
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
              server = {
                extraEnv = {
                  RUST_SRC_PATH = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
                    .. "/lib/rustlib/src/rust/library",
                },
              },
            },
          },
          capabilities = capabilities,
        },
      }

      for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
        local config = server_configs[server_name] or { capabilities = capabilities }
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
