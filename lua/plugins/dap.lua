local dap = require("dap")
local dapui = require("dapui")

require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()
require("dap-python").setup("python3")

if vim.fn.executable("uv") == 1 then
  require("dap-python").setup("uv")
end

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
    name = "Launch with CodeLLDB",
    type = "codelldb",
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
      local rust_pretty_print = os.getenv("RUST_LLDB_PRINT") or "/usr/lib/rustlib/etc/lldb_commands"

      if vim.fn.filereadable(rust_pretty_print) == 1 then
        return { "command source " .. rust_pretty_print }
      end
      return {}
    end,
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➔", texthl = "WarningMsg", linehl = "", numhl = "" })

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
