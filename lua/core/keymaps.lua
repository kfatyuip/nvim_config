local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if type(rhs) == "string" then
    rhs = "<cmd>" .. rhs .. "<cr>"
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set("n", ";", ":", { desc = "enter command mode" })

map("n", "<C-n>", "NvimTreeToggle", { desc = "nvimtree toggle window", silent = true })
map("n", "<leader>e", "NvimTreeFocus", { desc = "nvimtree focus window", silent = true })
map("n", "-", "Oil --float", { desc = "open parent directory", silent = true })

map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "format files", silent = true })

map("n", "<leader>lz", "Lazy", { desc = "open Lazy menu", silent = true })

map("n", "<leader>fl", "ToggleTerm direction=float", { desc = "open a floating terminal", silent = true })
map("n", "<leader>gi", "lua _lazygit_toggle()", { desc = "open lazygit", silent = true })
map("n", "<leader>py", "lua _python_toggle()", { desc = "open python", silent = true })
map("n", "<leader>ht", "lua _htop_toggle()", { desc = "open htop", silent = true })

map("n", "<leader>tl", "Telescope", { desc = "open telescope", silent = true })
map("n", "<leader>fw", "Telescope live_grep", { desc = "telescope live grep", silent = true })
map("n", "<leader>fb", "Telescope buffers", { desc = "telescope find buffers", silent = true })
map("n", "<leader>fh", "Telescope help_tags", { desc = "telescope help page", silent = true })
map("n", "<leader>ma", "Telescope marks", { desc = "telescope find marks", silent = true })
map("n", "<leader>fo", "Telescope oldfiles", { desc = "telescope find oldfiles", silent = true })
map(
  "n",
  "<leader>fz",
  "Telescope current_buffer_fuzzy_find",
  { desc = "telescope find in current buffer", silent = true }
)
map("n", "<leader>cm", "Telescope git_commits", { desc = "telescope git commits", silent = true })
map("n", "<leader>st", "Telescope git_status", { desc = "telescope git status", silent = true })
map("n", "<leader>ff", "Telescope find_files", { desc = "telescope find files", silent = true })
map("n", "<leader>jl", "Telescope jumplist", { desc = "telescope jumplist", silent = true })
map("n", "<leader>ft", require("telescope").extensions.flutter.commands, { desc = "open flutter tools", silent = true })

map("n", "<S-Tab>", "BufferPrevious", { desc = "move to previous buffer", silent = true })
map("n", "<Tab>", "BufferNext", { desc = "move to next buffer", silent = true })
map("n", "<A-,>", "BufferPrevious", { desc = "move to previous buffer", silent = true })
map("n", "<A-.>", "BufferNext", { desc = "move to next buffer", silent = true })
map("n", "<A-<>", "BufferMovePrevious", { desc = "move buffer left in tabline", silent = true })
map("n", "<A->>", "BufferMoveNext", { desc = "move buffer right in tabline", silent = true })
map("n", "<A-1>", "BufferGoto 1", { desc = "go to buffer 1", silent = true })
map("n", "<A-2>", "BufferGoto 2", { desc = "go to buffer 2", silent = true })
map("n", "<A-3>", "BufferGoto 3", { desc = "go to buffer 3", silent = true })
map("n", "<A-4>", "BufferGoto 4", { desc = "go to buffer 4", silent = true })
map("n", "<A-5>", "BufferGoto 5", { desc = "go to buffer 5", silent = true })
map("n", "<A-6>", "BufferGoto 6", { desc = "go to buffer 6", silent = true })
map("n", "<A-7>", "BufferGoto 7", { desc = "go to buffer 7", silent = true })
map("n", "<A-8>", "BufferGoto 8", { desc = "go to buffer 8", silent = true })
map("n", "<A-9>", "BufferGoto 9", { desc = "go to buffer 9", silent = true })
map("n", "<A-0>", "BufferLast", { desc = "go to last buffer", silent = true })
map("n", "<A-c>", "BufferClose", { desc = "close current buffer", silent = true })
map("n", "<C-p>", "BufferPick", { desc = "pick buffer from list", silent = true })
map("n", "<C-s-p>", "BufferPickDelete", { desc = "pick and delete buffer", silent = true })
map("n", "<leader>bb", "BufferOrderByBufferNumber", { desc = "sort buffers by number", silent = true })
map("n", "<leader>bn", "BufferOrderByName", { desc = "sort buffers by name", silent = true })
map("n", "<leader>bd", "BufferOrderByDirectory", { desc = "sort buffers by directory", silent = true })
map("n", "<leader>bl", "BufferOrderByLanguage", { desc = "sort buffers by language", silent = true })
map("n", "<leader>bw", "BufferOrderByWindowNumber", { desc = "sort buffers by window", silent = true })
map("n", "<leader>cl", "BufferCloseBuffersLeft", { desc = "close the left buffers", silent = true })
map("n", "<leader>cr", "BufferCloseBuffersRight", { desc = "close the right buffers", silent = true })
map("n", "<leader>x", "bd", { desc = "delete buffer", silent = true })

map("n", "<A-Up>", "resize +2", { desc = "Increase height", silent = true })
map("n", "<A-Down>", "resize -2", { desc = "decrease height", silent = true })
map("n", "<A-Left>", "vertical resize -2", { desc = "decrease width", silent = true })
map("n", "<A-Right>", "vertical resize +2", { desc = "increase width", silent = true })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true, silent = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true, silent = true })

map("n", "<leader>ca", "lua vim.lsp.buf.code_action()", { desc = "code action", silent = true })
map("n", "<leader>rn", "lua vim.lsp.buf.rename()", { desc = "lsp rename", silent = true })

map("n", "<leader>ds", "Trouble diagnostics", { desc = "lsp diagnostic loclist", silent = true })
map("n", "<leader>dS", "Telescope diagnostics", { desc = "lsp diagnostic loclist", silent = true })

map("n", "<leader>fs", "Trouble symbols", { desc = "list symbols", silent = true })
map("n", "<leader>fS", "Trouble lsp_document_symbols", { desc = "list document symbols", silent = true })

map("n", "<leader>ss", "Telescope lsp_document_symbols", { desc = "lsp document symbols", silent = true })

map("n", "gd", "Trouble lsp_definitions", { desc = "go to definition", silent = true })
map("n", "gD", "Telescope lsp_definitions", { desc = "go to definitions", silent = true })
map("n", "gr", "Trouble lsp_references", { desc = "go to references", silent = true })
map("n", "gR", "Telescope lsp_references", { desc = "go to references", silent = true })
map("n", "gi", "Telescope lsp_implementations", { desc = "go to implementations", silent = true })

map("n", "<leader>tn", "tabnew", { desc = "open a new tab", silent = true })

map("n", "<leader>ln", "InlayHintToggle", { desc = "inlay hint toggle", silent = true })

if vim.g.neovide then
  map({ "n", "v" }, "<C-+>", "lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1", { silent = true })
  map({ "n", "v" }, "<C-->", "lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1", { silent = true })
  map({ "n", "v" }, "<C-0>", "lua vim.g.neovide_scale_factor = 1", { silent = true })
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

map("n", "<leader>tdb", "Telescope dap list_breakpoints", { desc = "List Breakpoints", silent = true })
map("n", "<leader>tdc", "Telescope dap commands", { desc = "Commands", silent = true })
map("n", "<leader>tds", "Telescope dap configurations", { desc = "Configurations", silent = true })
map("n", "<leader>tdv", "Telescope dap variables", { desc = "Variables", silent = true })
map("n", "<leader>tdf", "Telescope dap frames", { desc = "Frames", silent = true })

local crates = require("crates")
map("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Crate Versions", silent = true })
map("n", "<leader>cf", crates.show_features_popup, { desc = "Show Crate Features", silent = true })
map("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show Crate Dependencies", silent = true })
map("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", silent = true })
map("n", "<leader>cU", crates.update_all_crates, { desc = "Update All Crates", silent = true })

map("n", "<leader>gs", "Gitsigns", { desc = "open Gitsigns", silent = true })
