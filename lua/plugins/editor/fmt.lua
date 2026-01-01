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

_G.merge_conform_config = function(content)
  if type(content) ~= "table" then
    return
  end
  current_config = vim.tbl_deep_extend("force", current_config, content)
end

_G.clear_conform_config = function()
  current_config = {}
end

_G.reset_conform_config = function()
  current_config = vim.deepcopy(default_config)
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = default_config.formatters_by_ft,
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
