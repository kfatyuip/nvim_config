local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
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
            RUST_SRC_PATH = vim.fn.trim(vim.fn.system("rustc --print sysroot")) .. "/lib/rustlib/src/rust/library",
          },
        },
      },
    },
    capabilities = capabilities,
  },
  pyright = {
    settings = {
      python = {
        venvPath = ".",
        pythonPath = "./.venv/bin/python",
      },
    },
    capabilities = capabilities,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
    end,
  },
}
