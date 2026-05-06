local default_config = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
}
local current_config = vim.deepcopy(default_config)

local M = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = current_config.formatters_by_ft,
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
}

function M.merge_conform_config(content)
  if type(content) ~= "table" then
    return
  end
  current_config = vim.tbl_deep_extend("force", current_config, content)
end

function M.clear_conform_config()
  current_config = {}
end

function M.reset_conform_config()
  current_config = vim.deepcopy(default_config)
end

return M
