local default_config = {
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "never" },
    json = { "jq" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "never" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    go = { "goimports", "gofmt" },
    toml = { "taplo" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    markdown = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
}

local M = {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  cmd = { "ConformInfo", "ConformConfigClear", "ConformConfigReset" },
  opts = {
    formatters_by_ft = vim.deepcopy(default_config.formatters_by_ft),
    notify_on_error = true,
  },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ lsp_fallback = true, async = true })
      end,
      desc = "Format",
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    local cmd = vim.api.nvim_create_user_command
    cmd("ConformConfigClear", function()
      M.clear_conform_config()
      vim.notify("Conform config cleared", vim.log.levels.INFO)
    end, { desc = "Clear conform.nvim config" })
    cmd("ConformConfigReset", function()
      M.reset_conform_config()
      vim.notify("Conform config reset", vim.log.levels.INFO)
    end, { desc = "Reset conform.nvim config" })
  end,
}

local function set_formatters(target, source)
  for k, v in pairs(source) do
    target[k] = v
  end
end

local function clear_formatters(target)
  for ft in pairs(target) do
    target[ft] = nil
  end
end

function M.set_conform_config(content, opts)
  if type(content) ~= "table" then
    return
  end
  opts = opts or {}
  local conform = require("conform")
  if opts.reset then
    clear_formatters(conform.formatters_by_ft)
    set_formatters(conform.formatters_by_ft, vim.deepcopy(default_config.formatters_by_ft))
  end
  if content.formatters_by_ft then
    set_formatters(conform.formatters_by_ft, content.formatters_by_ft)
  end
end

function M.merge_conform_config(content)
  M.set_conform_config(content, { reset = false })
end

function M.clear_conform_config()
  clear_formatters(require("conform").formatters_by_ft)
end

function M.reset_conform_config()
  local conform = require("conform")
  clear_formatters(conform.formatters_by_ft)
  set_formatters(conform.formatters_by_ft, vim.deepcopy(default_config.formatters_by_ft))
end

return M
