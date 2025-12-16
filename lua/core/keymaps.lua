local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if type(rhs) == "string" then
    rhs = "<cmd>" .. rhs .. "<cr>"
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set("n", ";", ":", { desc = "enter command mode" })

vim.keymap.set("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true, silent = true })

map("n", "<C-n>", "NvimTreeToggle", { desc = "nvimtree toggle window", silent = true })
map("n", "<leader>e", "NvimTreeFocus", { desc = "nvimtree focus window", silent = true })
map("n", "-", "Oil --float", { desc = "open parent directory", silent = true })

map("n", "<leader>lz", "Lazy", { desc = "open Lazy menu", silent = true })

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

map("n", "<A-Up>", "resize +2", { desc = "increase height", silent = true })
map("n", "<A-Down>", "resize -2", { desc = "decrease height", silent = true })
map("n", "<A-Left>", "vertical resize -2", { desc = "decrease width", silent = true })
map("n", "<A-Right>", "vertical resize +2", { desc = "increase width", silent = true })

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

map("n", "<leader>ft", "Telescope flutter commands", { desc = "open flutter tools", silent = true })

map("n", "<leader>tn", "tabnew", { desc = "open a new tab", silent = true })

map("n", "<leader>ln", "InlayHintToggle", { desc = "inlay hint toggle", silent = true })

if vim.g.neovide then
  map({ "n", "v" }, "<C-+>", "lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1", { silent = true })
  map({ "n", "v" }, "<C-->", "lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1", { silent = true })
  map({ "n", "v" }, "<C-0>", "lua vim.g.neovide_scale_factor = 1", { silent = true })
end
