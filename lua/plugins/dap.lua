local dap = require("dap")
local dapui = require("dapui")
local map = vim.keymap.set

require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()
require("dap-python").setup("python3")

local lldb_path = vim.fn.exepath("lldb-dap") or (os.getenv("PREFIX") or "/usr") .. "/bin/lldb-dap"

dap.adapters.lldb = {
  type = "executable",
  command = lldb_path,
  name = "lldb",
}

dap.adapters.codelldb = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = vim.fn.exepath("codelldb") or "codelldb",
    args = { "--port", "${port}" },
  },
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
dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
  {
    name = "Rust Launch (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      local cargo_target = vim.fn.getcwd() .. "/target/debug/"
      local candidates = vim.split(vim.fn.glob(cargo_target .. "*"), "\n")

      for _, candidate in ipairs(candidates) do
        if vim.fn.executable(candidate) == 1 then
          return candidate
        end
      end

      return vim.fn.input("Path to executable: ", cargo_target, "file")
    end,
    cwd = "${workspaceFolder}",
    terminal = "integrated",
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input("Enter arguments (space-separated): ")
      return vim.split(input, " ")
    end,
    initCommands = function()
      local rust_pretty_print = os.getenv("RUST_LLDB_PRINT") or "/usr/share/rust/src/etc/lldb_commands"

      if vim.fn.filereadable(rust_pretty_print) == 1 then
        return { "command source " .. rust_pretty_print }
      end
      return {}
    end,
  },
  {
    name = "Rust Launch (LLDB)",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input("Enter arguments: ")
      return vim.split(input, " ")
    end,
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➔", texthl = "WarningMsg", linehl = "", numhl = "" })

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

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.3 },
        { id = "breakpoints", size = 0.2 },
        { id = "stacks", size = 0.2 },
        { id = "watches", size = 0.3 },
      },
      size = 0.3,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.8 },
        { id = "console", size = 0.2 },
      },
      size = 0.3,
      position = "bottom",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close
