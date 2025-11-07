local map = vim.keymap.set

local function Ex(cmd)
  return function()
    vim.cmd(cmd)
  end
end

map("n", ";", ":", { desc = "enter command mode" })

map("n", "<C-n>", Ex("NvimTreeToggle"), { desc = "nvimtree toggle window", silent = true })
map("n", "<leader>e", Ex("NvimTreeFocus"), { desc = "nvimtree focus window", silent = true })
map("n", "-", Ex("Oil --float"), { desc = "open parent directory", silent = true })

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files", silent = true })

map("n", "<leader>lz", Ex("Lazy"), { desc = "open Lazy menu", silent = true })

map("n", "<leader>fl", Ex("ToggleTerm direction=float"), { desc = "open a floating terminal", silent = true })
map("n", "<leader>gi", "<cmd>lua _lazygit_toggle()<cr>", { desc = "open lazygit", silent = true })
map("n", "<leader>py", "<cmd>lua _python_toggle()<cr>", { desc = "open python", silent = true })
map("n", "<leader>ht", "<cmd>lua _htop_toggle()<cr>", { desc = "open htop", silent = true })

map("n", "<leader>tl", Ex("Telescope"), { desc = "open telescope", silent = true })
map("n", "<leader>fw", Ex("Telescope live_grep"), { desc = "telescope live grep", silent = true })
map("n", "<leader>fb", Ex("Telescope buffers"), { desc = "telescope find buffers", silent = true })
map("n", "<leader>fh", Ex("Telescope help_tags"), { desc = "telescope help page", silent = true })
map("n", "<leader>ma", Ex("Telescope marks"), { desc = "telescope find marks", silent = true })
map("n", "<leader>fo", Ex("Telescope oldfiles"), { desc = "telescope find oldfiles", silent = true })
map(
  "n",
  "<leader>fz",
  Ex("Telescope current_buffer_fuzzy_find"),
  { desc = "telescope find in current buffer", silent = true }
)
map("n", "<leader>cm", Ex("Telescope git_commits"), { desc = "telescope git commits", silent = true })
map("n", "<leader>st", Ex("Telescope git_status"), { desc = "telescope git status", silent = true })
map("n", "<leader>ff", Ex("Telescope find_files"), { desc = "telescope find files", silent = true })
map("n", "<leader>jl", Ex("Telescope jumplist"), { desc = "telescope jumplist", silent = true })
map("n", "<leader>ft", require("telescope").extensions.flutter.commands, { desc = "open flutter tools", silent = true })

map("n", "<S-Tab>", Ex("BufferPrevious"), { desc = "move to previous buffer", silent = true })
map("n", "<Tab>", Ex("BufferNext"), { desc = "move to next buffer", silent = true })
map("n", "<A-,>", Ex("BufferPrevious"), { desc = "move to previous buffer", silent = true })
map("n", "<A-.>", Ex("BufferNext"), { desc = "move to next buffer", silent = true })
map("n", "<A-<>", Ex("BufferMovePrevious"), { desc = "move buffer left in tabline", silent = true })
map("n", "<A->>", Ex("BufferMoveNext"), { desc = "move buffer right in tabline", silent = true })
map("n", "<A-1>", Ex("BufferGoto 1"), { desc = "go to buffer 1", silent = true })
map("n", "<A-2>", Ex("BufferGoto 2"), { desc = "go to buffer 2", silent = true })
map("n", "<A-3>", Ex("BufferGoto 3"), { desc = "go to buffer 3", silent = true })
map("n", "<A-4>", Ex("BufferGoto 4"), { desc = "go to buffer 4", silent = true })
map("n", "<A-5>", Ex("BufferGoto 5"), { desc = "go to buffer 5", silent = true })
map("n", "<A-6>", Ex("BufferGoto 6"), { desc = "go to buffer 6", silent = true })
map("n", "<A-7>", Ex("BufferGoto 7"), { desc = "go to buffer 7", silent = true })
map("n", "<A-8>", Ex("BufferGoto 8"), { desc = "go to buffer 8", silent = true })
map("n", "<A-9>", Ex("BufferGoto 9"), { desc = "go to buffer 9", silent = true })
map("n", "<A-0>", Ex("BufferLast"), { desc = "go to last buffer", silent = true })
map("n", "<A-c>", Ex("BufferClose"), { desc = "close current buffer", silent = true })
map("n", "<C-p>", Ex("BufferPick"), { desc = "pick buffer from list", silent = true })
map("n", "<C-s-p>", Ex("BufferPickDelete"), { desc = "pick and delete buffer", silent = true })
map("n", "<leader>bb", Ex("BufferOrderByBufferNumber"), { desc = "sort buffers by number", silent = true })
map("n", "<leader>bn", Ex("BufferOrderByName"), { desc = "sort buffers by name", silent = true })
map("n", "<leader>bd", Ex("BufferOrderByDirectory"), { desc = "sort buffers by directory", silent = true })
map("n", "<leader>bl", Ex("BufferOrderByLanguage"), { desc = "sort buffers by language", silent = true })
map("n", "<leader>bw", Ex("BufferOrderByWindowNumber"), { desc = "sort buffers by window", silent = true })
map("n", "<leader>cl", Ex("BufferCloseBuffersLeft"), { desc = "close the left buffers", silent = true })
map("n", "<leader>cr", Ex("BufferCloseBuffersRight"), { desc = "close the right buffers", silent = true })
map("n", "<leader>x", Ex("bd"), { desc = "delete buffer", silent = true })

map("n", "<A-Up>", Ex("resize +2"), { desc = "Increase height", silent = true })
map("n", "<A-Down>", Ex("resize -2"), { desc = "decrease height", silent = true })
map("n", "<A-Left>", Ex("vertical resize -2"), { desc = "decrease width", silent = true })
map("n", "<A-Right>", Ex("vertical resize +2"), { desc = "increase width", silent = true })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true, silent = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true, silent = true })

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "code action", silent = true })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "lsp rename", silent = true })

map("n", "<leader>ds", Ex("Trouble diagnostics"), { desc = "lsp diagnostic loclist", silent = true })
map("n", "<leader>dS", Ex("Telescope diagnostics"), { desc = "lsp diagnostic loclist", silent = true })

map("n", "<leader>fs", Ex("Trouble symbols"), { desc = "list symbols", silent = true })
map("n", "<leader>fS", Ex("Trouble lsp_document_symbols"), { desc = "list document symbols", silent = true })

map("n", "<leader>ss", Ex("Telescope lsp_document_symbols"), { desc = "lsp document symbols", silent = true })

map("n", "gd", Ex("Trouble lsp_definitions"), { desc = "go to definition", silent = true })
map("n", "gD", Ex("Telescope lsp_definitions"), { desc = "go to definitions", silent = true })
map("n", "gr", Ex("Trouble lsp_references"), { desc = "go to references", silent = true })
map("n", "gR", Ex("Telescope lsp_references"), { desc = "go to references", silent = true })
map("n", "gi", Ex("Telescope lsp_implementations"), { desc = "go to implementations", silent = true })

map("n", "<leader>tn", Ex("tabnew"), { desc = "open a new tab", silent = true })

map("n", "<leader>ln", Ex("InlayHintToggle"), { desc = "inlay hint toggle", silent = true })

if vim.g.neovide then
  map(
    { "n", "v" },
    "<C-+>",
    "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<cr>",
    { silent = true }
  )
  map(
    { "n", "v" },
    "<C-->",
    "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<cr>",
    { silent = true }
  )
  map({ "n", "v" }, "<C-0>", "<cmd>lua vim.g.neovide_scale_factor = 1<cr>", { silent = true })
end

local dap = require("dap")
map("n", "<F5>", dap.continue, { desc = "Continue", silent = true })
map("n", "<F10>", dap.step_over, { desc = "Step Over", silent = true })
map("n", "<F11>", dap.step_into, { desc = "Step Into", silent = true })
map("n", "<F12>", dap.step_out, { desc = "Step Out", silent = true })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", silent = true })
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint", silent = true })
map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL", silent = true })
map("n", "<leader>dl", dap.run_last, { desc = "Run Last", silent = true })
map({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Hover", silent = true })
map({ "n", "v" }, "<leader>dp", require("dap.ui.widgets").preview, { desc = "Preview", silent = true })
map("n", "<leader>dlp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Log Point", silent = true })
map("n", "<leader>de", dap.terminate, { desc = "Terminate", silent = true })

map("n", "<leader>tdb", Ex("Telescope dap list_breakpoints"), { desc = "List Breakpoints", silent = true })
map("n", "<leader>tdc", Ex("Telescope dap commands"), { desc = "Commands", silent = true })
map("n", "<leader>tds", Ex("Telescope dap configurations"), { desc = "Configurations", silent = true })
map("n", "<leader>tdv", Ex("Telescope dap variables"), { desc = "Variables", silent = true })
map("n", "<leader>tdf", Ex("Telescope dap frames"), { desc = "Frames", silent = true })

local crates = require("crates")
map("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Crate Versions", silent = true })
map("n", "<leader>cf", crates.show_features_popup, { desc = "Show Crate Features", silent = true })
map("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show Crate Dependencies", silent = true })
map("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", silent = true })
map("n", "<leader>cU", crates.update_all_crates, { desc = "Update All Crates", silent = true })

map("n", "<leader>gs", Ex("Gitsigns"), { desc = "open Gitsigns", silent = true })
