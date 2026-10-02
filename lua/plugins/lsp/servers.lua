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
        check = { command = "clippy" },
        cargo = {
          buildScripts = { enable = true },
          allFeatures = true,
        },
        procMacro = { enable = true },
      },
    },
  },
  basedpyright = {
    filetypes = { "python" },
    settings = {
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
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      vim.schedule(function()
        local registry_ok, _ = pcall(require, "mason-registry")
        local map_ok, _ = pcall(require, "mason-lspconfig.mappings")
        if not registry_ok or not map_ok then
          return
        end
      end)

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
