return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files", silent = true },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep", silent = true },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers", silent = true },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags", silent = true },
    { "<leader>ma", "<cmd>Telescope marks<cr>", desc = "Find marks", silent = true },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old files", silent = true },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in buffer", silent = true },
    { "<leader>cm", "<cmd>Telescope git_commits<cr>", desc = "Git commits", silent = true },
    { "<leader>st", "<cmd>Telescope git_status<cr>", desc = "Git status", silent = true },
    { "<leader>tl", "<cmd>Telescope<cr>", desc = "Open telescope", silent = true },
    { "<leader>jl", "<cmd>Telescope jumplist<cr>", desc = "Jumplist", silent = true },
  },
}
