local blink = require("blink.cmp")
local files = require("mini.files")
local flash = require("flash")
local move = require("mini.move")
local surround = require("mini.surround")

blink.setup({
  fuzzy = { implementation = "rust" },
  keymap = { preset = "default" },
  signature = { enabled = true },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

flash.setup()

files.setup()

move.setup({
  mappings = {
    line_down = "<C-j>",
    line_up = "<C-k>",
  },
})

surround.setup({
  mappings = {
    add = "<leader>sa",       -- Add surrounding in Normal and Visual modes
    delete = "<leader>sd",    -- Delete surrounding
    find = "<leader>sf",      -- Find surrounding (to the right)
    find_left = "<leader>sF", -- Find surrounding (to the left)
    highlight = "<leader>sh", -- Highlight surrounding
    replace = "<leader>sr",   -- Replace surrounding
  },
})
