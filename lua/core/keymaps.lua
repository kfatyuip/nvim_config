local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "nvimtree focus window" })

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files" })

map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<cr>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<cr>", { desc = "telescope git commits" })
map("n", "<leader>st", "<cmd>Telescope git_status<cr>", { desc = "telescope git status" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>jl", "<cmd>Telescope jumplist<cr>", { desc = "telescope jumplist" })

map("n", "<leader>cl", "<cmd>BufferLineCloseLeft<cr>", { desc = "close left buffers" })
map("n", "<leader>cr", "<cmd>BufferLineCloseRight<cr>", { desc = "close right buffers" })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "move to next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "move to previous buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "delete buffer" })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action<cr>", { desc = "code action" })

-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
map("n", "<leader>ds", "<cmd>Trouble diagnostics<cr>", { desc = "lsp diagnostic loclist" })
map("n", "<leader>dS", "<cmd>Telescope diagnostics<cr>", { desc = "lsp diagnostic loclist" })

map("n", "<leader>fs", "<cmd>Trouble symbols<cr>", { desc = "" })
map("n", "<leader>fS", "<cmd>Trouble lsp_document_symbols<cr>")

map("n", "<leader>fl", "<cmd>FloatermNew<cr>", { desc = "open a floating terminal" })
map("n", "<leader>ft", require("telescope").extensions.flutter.commands, { desc = "open flutter tools" })

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
map("n", "gD", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definitions" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "Go to references" })
map("n", "gR", "<cmd>Telescope lsp_references<cr>", { desc = "Goto references" })
map("n", "gi", "<cmd>luavim.lsp.buf.implementation<cr>", { desc = "Go to implementation" })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to implementations" })
