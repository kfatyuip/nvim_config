local dap = require("dap")
local dapui = require("dapui")
local map = vim.keymap.set

require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()
require("dap-python").setup("python3")

dap.adapters.lldb = {
  type = "executable",
  command = (os.getenv("PREFIX") or "/usr") .. "/bin/lldb-dap",
  name = "lldb",
}

dap.configurations.c = {
  {
    name = "Launch with LLDB",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input("Enter arguments (space-separated): ")
      return vim.split(input, " ")
    end,
    runInTerminal = false,
  },
}

dap.configurations.rust = dap.configurations.c

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })

map("n", "<F5>", dap.continue, { desc = "continue" })
map("n", "<F10>", dap.step_over, { desc = "step over" })
map("n", "<F11>", dap.step_into, { desc = "step into" })
map("n", "<F12>", dap.step_out, { desc = "step out" })
map("n", "<Leader>b", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
map("n", "<Leader>B", dap.set_breakpoint, { desc = "set breakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "open repl" })
map("n", "<Leader>dl", dap.run_last, { desc = "run last" })
map({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "hover" })
map({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview, { desc = "preview" })
map("n", "<Leader>lp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "log point" })
map("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end, { desc = "frames" })
map("n", "<Leader>dw", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "scopes" })
map("n", "<leader>de", "<cmd>DapTerminate<cr>", { desc = "terminate" })

map("n", "<leader>tdb", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "list breakpoints" })
map("n", "<leader>tdc", "<cmd>Telescope dap commands<cr>", { desc = "commands" })
map("n", "<leader>tds", "<cmd>Telescope dap configurations<cr>", { desc = "configurations" })
map("n", "<leader>tdt", "<cmd>Telescope dap variables<cr>", { desc = "variables" })
map("n", "<leader>tdf", "<cmd>Telescope dap frames<cr>", { desc = "frames" })

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
