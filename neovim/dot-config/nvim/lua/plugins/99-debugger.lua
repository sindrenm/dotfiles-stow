local dap = require("dap")
local dapView = require("dap-view")

dapView.setup({
  auto_toggle = true
})

-- 1. Setup Adapter
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  }
}

-- 2. Setup Rust Configuration
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Automatically build and find the executable
      vim.fn.jobstart("cargo build")
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
