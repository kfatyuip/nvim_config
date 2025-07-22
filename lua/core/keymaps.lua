local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "nvimtree focus window" })

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files" })

map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "open Lazy menu" })
map("n", "<leader>fl", "<cmd>ToggleTerm direction=float<cr>", { desc = "open a floating terminal" })

map("n", "<leader>tl", "<cmd>Telescope<cr>", { desc = "open telescope" })
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
map("n", "<leader>ft", require("telescope").extensions.flutter.commands, { desc = "open flutter tools" })

map("n", "<leader>cl", "<cmd>BufferLineCloseLeft<cr>", { desc = "close left buffers" })
map("n", "<leader>cr", "<cmd>BufferLineCloseRight<cr>", { desc = "close right buffers" })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "move to next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "move to previous buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "delete buffer" })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "code action" })

-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
map("n", "<leader>ds", "<cmd>Trouble diagnostics<cr>", { desc = "lsp diagnostic loclist" })
map("n", "<leader>dS", "<cmd>Telescope diagnostics<cr>", { desc = "lsp diagnostic loclist" })

map("n", "<leader>fs", "<cmd>Trouble symbols<cr>", { desc = "list symbols" })
map("n", "<leader>fS", "<cmd>Trouble lsp_document_symbols<cr>", { desc = "list document symbols" })

map("n", "gd", "<cmd>Trouble lsp_definitions<cr>", { desc = "go to definition" })
map("n", "gD", "<cmd>Telescope lsp_definitions<cr>", { desc = "go to definitions" })
map("n", "gr", "<cmd>Trouble lsp_references<cr>", { desc = "go to references" })
map("n", "gR", "<cmd>Telescope lsp_references<cr>", { desc = "go to references" })
-- map("n", "gi", "<cmd>Trouble lsp_implementations<cr>", { desc = "go to implementation" })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "go to implementations" })

map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "open a new tab" })

map("n", "<leader>ln", "<cmd>InlayHintToggle<cr>", { desc = "inlay hint toggle" })

if vim.g.neovide then
  map({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  map({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  map({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

local dap = require("dap")
map("n", "<F5>", dap.continue, { desc = "Continue" })
map("n", "<F10>", dap.step_over, { desc = "Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Step Out" })
map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<Leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<Leader>dl", dap.run_last, { desc = "Run Last" })
map({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
map({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview, { desc = "Preview" })
map("n", "<Leader>dlp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Log Point" })
map("n", "<Leader>de", dap.terminate, { desc = "Terminate" })

map("n", "<leader>tdb", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "List Breakpoints" })
map("n", "<leader>tdc", "<cmd>Telescope dap commands<cr>", { desc = "Commands" })
map("n", "<leader>tds", "<cmd>Telescope dap configurations<cr>", { desc = "Configurations" })
map("n", "<leader>tdv", "<cmd>Telescope dap variables<cr>", { desc = "Variables" })
map("n", "<leader>tdf", "<cmd>Telescope dap frames<cr>", { desc = "Frames" })

local crates = require("crates")
map("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Crate Versions" })
map("n", "<leader>cf", crates.show_features_popup, { desc = "Show Crate Features" })
map("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show Crate Dependencies" })
map("n", "<leader>cu", crates.update_crate, { desc = "Update Crate" })
map("n", "<leader>cU", crates.update_all_crates, { desc = "Update All Crates" })
