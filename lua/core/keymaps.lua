local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map(
  "n",
  "<C-n>",
  "<cmd>NvimTreeToggle<CR>",
  { desc = "nvimtree toggle window" }
)
map(
  "n",
  "<leader>e",
  "<cmd>NvimTreeFocus<CR>",
  { desc = "nvimtree focus window" }
)

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files" })

map(
  "n",
  "<leader>fw",
  "<cmd>Telescope live_grep<CR>",
  { desc = "telescope live grep" }
)
map(
  "n",
  "<leader>fb",
  "<cmd>Telescope buffers<CR>",
  { desc = "telescope find buffers" }
)
map(
  "n",
  "<leader>fh",
  "<cmd>Telescope help_tags<CR>",
  { desc = "telescope help page" }
)
map(
  "n",
  "<leader>ma",
  "<cmd>Telescope marks<CR>",
  { desc = "telescope find marks" }
)
map(
  "n",
  "<leader>fo",
  "<cmd>Telescope oldfiles<CR>",
  { desc = "telescope find oldfiles" }
)
map(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "telescope find in current buffer" }
)
map(
  "n",
  "<leader>cm",
  "<cmd>Telescope git_commits<CR>",
  { desc = "telescope git commits" }
)
map(
  "n",
  "<leader>st",
  "<cmd>Telescope git_status<CR>",
  { desc = "telescope git status" }
)
map(
  "n",
  "<leader>ff",
  "<cmd>Telescope find_files<cr>",
  { desc = "telescope find files" }
)

map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "move to next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "move to previous buffer" })
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "delete buffer" })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
map(
  "n",
  "<leader>ds",
  vim.diagnostic.setloclist,
  { desc = "lsp diagnostic loclist" }
)

map(
  "n",
  "<leader>ft",
  require("telescope").extensions.flutter.commands,
  { desc = "open flutter tools" }
)
