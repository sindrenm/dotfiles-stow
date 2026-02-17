local dap = require("dap")
local files = require("mini.files")
local flash = require("flash")
local telescope = require("telescope.builtin")
local whichKey = require("which-key")

whichKey.setup({ preset = "modern" });

whichKey.add({
  { "-", mode = "n", files.open, desc = "Open file picker" },
})

whichKey.add({
  { "<leader>p",  mode = "n", group = "Packages" },
  { "<leader>pu", mode = "n", vim.pack.update,   desc = "Update packages" },
})

whichKey.add({
  { "<leader>f",    mode = "n", group = "Find [Telescope]" },
  { "<leader>ff",   mode = "n", telescope.find_files,            desc = "Find file" },
  { "<leader>fg",   mode = "n", telescope.live_grep,             desc = "Grep" },
  { "<leader>fh",   mode = "n", telescope.help_tags,             desc = "Help tags" },
  { "<leader>fb",   mode = "n", telescope.buffers,               desc = "Buffers" },
  { "<leader>fr",   mode = "n", telescope.resume,                desc = "Resume" },
  { "<leader>fs",   mode = "n", telescope.treesitter,            desc = "Treesitter" },
  { "<leader>fvf",  mode = "n", telescope.git_files,             desc = "Git files" },
  { "<leader>fvcw", mode = "n", telescope.git_commits,           desc = "Git commits" },
  { "<leader>fvcb", mode = "n", telescope.git_bcommits,          desc = "Git buffer commits" },
  { "<leader>fvb",  mode = "n", telescope.git_branches,          desc = "Git branches" },
  { "<leader>fvs",  mode = "n", telescope.git_status,            desc = "Git status" },
  { "<leader>fvx",  mode = "n", telescope.git_stash,             desc = "Git stash" },
  { "<leader>flsb", mode = "n", telescope.lsp_document_symbols,  desc = "LSP Document Symbols" },
  { "<leader>flsw", mode = "n", telescope.lsp_workspace_symbols, desc = "LSP Workspace Symbols" },
  { "<leader>flr",  mode = "n", telescope.lsp_references,        desc = "LSP References" },
  { "<leader>fli",  mode = "n", telescope.lsp_implementations,   desc = "LSP Implementations" },
  { "<leader>flD",  mode = "n", telescope.lsp_definitions,       desc = "LSP Definitions" },
  { "<leader>flt",  mode = "n", telescope.lsp_type_definitions,  desc = "LSP Type Definitions" },
  { "<leader>fld",  mode = "n", telescope.diagnostics,           desc = "Diagnostics" },
})

whichKey.add({
  { "<leader>l",   mode = { "n", "x", "o" }, group = "Language Server" },
  { "<leader>lgD", mode = "n",               vim.lsp.buf.declaration,             desc = "Go to declaration" },
  { "<leader>lgd", mode = "n",               vim.lsp.buf.definition,              desc = "Go to definition" },
  { "<leader>lgt", mode = "n",               vim.lsp.buf.type_definition,         desc = "Go to type" },
  { "<leader>lgi", mode = "n",               vim.lsp.buf.implementation,          desc = "List implementations" },
  { "<leader>lgr", mode = "n",               vim.lsp.buf.references,              desc = "List references" },
  { "<leader>lgn", mode = "n",               vim.diagnostic.goto_next,            desc = "Go to next diagnostic" },
  { "<leader>lgp", mode = "n",               vim.diagnostic.goto_prev,            desc = "Go to previous diagnostic" },
  { "<leader>le",  mode = "n",               vim.diagnostic.open_float,           desc = "Open diagnostic float" },
  { "<leader>lH",  mode = "n",               vim.lsp.buf.document_highlight,      desc = "Document highlight" },
  { "<leader>lS",  mode = "n",               vim.lsp.buf.document_symbol,         desc = "List document symbols" },
  { "<leader>lwa", mode = "n",               vim.lsp.buf.add_workspace_folder,    desc = "Add workspace folder" },
  { "<leader>lwr", mode = "n",               vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
  { "<leader>lws", mode = "n",               vim.lsp.buf.workspace_symbol,        desc = "List workspace symbols" },
  { "<leader>lh",  mode = "n",               vim.lsp.buf.hover,                   desc = "Trigger hover" },
  { "<leader>ls",  mode = "n",               vim.lsp.buf.signature_help,          desc = "Signature help" },
  { "<leader>ln",  mode = "n",               vim.lsp.buf.rename,                  desc = "Rename symbol" },
  { "<leader>la",  mode = { "n", "x", "o" }, vim.lsp.buf.code_action,             desc = "Code action" },
  { "<leader>lf",  mode = "n",               vim.lsp.buf.format,                  desc = "Format buffer" },
})

whichKey.add({
  { "s", mode = { "n", "x", "o" }, flash.jump, desc = "Flash Jump" },
})

whichKey.add({
  { "<leader>d",    mode = "n", group = "Debugger" },
  { "<leader>dc",   mode = "n", dap.continue,          desc = "Continue debugger" },
  { "<leader>dR",   mode = "n", dap.restart,           desc = "Restart debug session" },
  { "<leader>dq",   mode = "n", dap.terminate,         desc = "Terminate debug session" },
  { "<leader>d.",   mode = "n", dap.run_last,          desc = "Run last debug session" },
  { "<leader>db",   mode = "n", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
  { "<leader>dgc",  mode = "n", dap.run_to_cursor,     desc = "Run to cursor" },
  { "<leader>dgi",  mode = "n", dap.step_into,         desc = "Step into" },
  { "<leader>dgo",  mode = "n", dap.step_out,          desc = "Step out" },
  { "<leader>dgj",  mode = "n", dap.step_over,         desc = "Step over" },
  { "<leader>dgk",  mode = "n", dap.step_back,         desc = "Step back" },
  { "<leader>dgsk", mode = "n", dap.up,                desc = "Go up stacktrace" },
  { "<leader>dgsj", mode = "n", dap.down,              desc = "Go down stacktrace" },
})

whichKey.add({
  -- NOTE: Actual mappings are set through `mini.surround.setup()`.
  { "<leader>s",  mode = { "n", "x", "o" }, group = "Surround" },
  { "<leader>sa", mode = { "x", "o" },      desc = "Add surrounding to selection" },
  { "<leader>sa", mode = "n",               desc = "Add surrounding" },
  { "<leader>sd", mode = "n",               desc = "Delete surrounding" },
  { "<leader>sf", mode = "n",               desc = "Find right surrounding" },
  { "<leader>sF", mode = "n",               desc = "Find left surrounding" },
  { "<leader>sh", mode = "n",               desc = "Highlight surrounding" },
  { "<leader>sr", mode = "n",               desc = "Replace surrounding" },
})

whichKey.add({
  -- NOTE: Actual mappings are set through `mini.move.setup()`.
  { "<C-j>", desc = "Move line down" },
  { "<C-k>", desc = "Move line up" },
})

whichKey.add({
  -- NOTE: Actual mappings are set through `toggleterm.setup()`.
  { [[<C-\>]], desc = "Toggle terminal" },
})
