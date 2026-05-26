vim.keymap.set("n", ";", ":", { desc = "Enter command mode" })

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy", silent = true })

vim.keymap.set("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true, silent = true })
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comment line", remap = true, silent = true })

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code action", silent = true })
vim.keymap.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "LSP rename", silent = true })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab", silent = true })
vim.keymap.set("n", "<leader>ln", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints", silent = true })

vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase height", silent = true })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height", silent = true })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width", silent = true })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width", silent = true })

if vim.g.neovide then
  vim.keymap.set(
    { "n", "v" },
    "<C-+>",
    "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<cr>",
    { silent = true }
  )
  vim.keymap.set(
    { "n", "v" },
    "<C-_>",
    "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<cr>",
    { silent = true }
  )
  vim.keymap.set({ "n", "v" }, "<C-0>", "<cmd>lua vim.g.neovide_scale_factor = 1<cr>", { silent = true })
end
