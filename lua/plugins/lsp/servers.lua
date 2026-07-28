local servers = {
  lua_ls = {
    filetypes = { "lua" },
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        codeLens = { enable = true },
      },
    },
  },
  rust_analyzer = {
    filetypes = { "rust" },
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
  },
  basedpyright = {
    filetypes = { "python" },
    settings = {
      python = {
        pythonPath = vim.fn.exepath("python"),
      },
      basedpyright = {
        analysis = {
          typeCheckingMode = "recommended",
          diagnosticMode = "openFilesOnly",
          inlayHints = {
            callArgumentNames = true,
          },
        },
      },
    },
  },
}

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
  },
}
