local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map(
  "n",
  "<C-n>",
  "<cmd>NvimTreeToggle<cr>",
  { desc = "nvimtree toggle window" }
)
map(
  "n",
  "<leader>e",
  "<cmd>NvimTreeFocus<cr>",
  { desc = "nvimtree focus window" }
)

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files" })

map(
  "n",
  "<leader>fw",
  "<cmd>Telescope live_grep<cr>",
  { desc = "telescope live grep" }
)
map(
  "n",
  "<leader>fb",
  "<cmd>Telescope buffers<cr>",
  { desc = "telescope find buffers" }
)
map(
  "n",
  "<leader>fh",
  "<cmd>Telescope help_tags<cr>",
  { desc = "telescope help page" }
)
map(
  "n",
  "<leader>ma",
  "<cmd>Telescope marks<cr>",
  { desc = "telescope find marks" }
)
map(
  "n",
  "<leader>fo",
  "<cmd>Telescope oldfiles<cr>",
  { desc = "telescope find oldfiles" }
)
map(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  { desc = "telescope find in current buffer" }
)
map(
  "n",
  "<leader>cm",
  "<cmd>Telescope git_commits<cr>",
  { desc = "telescope git commits" }
)
map(
  "n",
  "<leader>st",
  "<cmd>Telescope git_status<cr>",
  { desc = "telescope git status" }
)
map(
  "n",
  "<leader>ff",
  "<cmd>Telescope find_files<cr>",
  { desc = "telescope find files" }
)

map(
  "n",
  "<Tab>",
  "<cmd>BufferLineCycleNext<cr>",
  { desc = "move to next buffer" }
)
map(
  "n",
  "<S-Tab>",
  "<cmd>BufferLineCyclePrev<cr>",
  { desc = "move to previous buffer" }
)
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "delete buffer" })

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
  "<leader>dS",
  "<cmd>Telescope diagnostics<cr>",
  { desc = "lsp diagnostic loclist" }
)

map("n", "<leader>fs", "<cmd>Vista<cr>", { desc = "focus Vista" })

map(
  "n",
  "<leader>ft",
  require("telescope").extensions.flutter.commands,
  { desc = "open flutter tools" }
)
