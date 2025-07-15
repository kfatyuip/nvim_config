local dap = require("dap")
local dapui = require("dapui")

require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup()

if vim.fn.executable("uv") == 1 then
  require("dap-python").setup("uv")
else
  require("dap-python").setup("python3")
end

local function read_args()
  local args_string = vim.fn.input("Arguments: ")
  local utils = require("dap.utils")
  if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
    return utils.splitstr(args_string)
  end
  return vim.split(args_string, " +")
end

local function pick_executable(lang)
  local default_dir = vim.fn.getcwd()
  local candidate_glob = ""
  if lang == "rust" then
    default_dir = default_dir .. "/target/debug/"
    candidate_glob = default_dir .. "*"
  else
    default_dir = default_dir .. "/"
    candidate_glob = default_dir .. "*"
  end
  local candidates = vim.split(vim.fn.glob(candidate_glob), "\n")
  for _, candidate in ipairs(candidates) do
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return vim.fn.input("Path to executable: ", default_dir, "file")
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

local function rust_init_commands()
  local rust_pretty_print = os.getenv("RUST_LLDB_PRINT") or "/usr/lib/rustlib/etc/lldb_commands"
  if vim.fn.filereadable(rust_pretty_print) == 1 then
    return { "command source " .. rust_pretty_print }
  end
  return {}
end

local function generate_dap_config(lang)
  local base_config = {
    {
      name = "file (CodeLLDB)",
      type = "codelldb",
      request = "launch",
      program = function()
        return pick_executable(lang)
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      terminal = "integrated",
    },
    {
      name = "file:args (CodeLLDB)",
      type = "codelldb",
      request = "launch",
      program = function()
        return pick_executable(lang)
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = read_args,
      terminal = "integrated",
    },
  }
  if lang == "rust" then
    for _, config in ipairs(base_config) do
      config.initCommands = rust_init_commands
    end
  end

  return base_config
end

dap.configurations.c = generate_dap_config("c")
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = generate_dap_config("rust")

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
