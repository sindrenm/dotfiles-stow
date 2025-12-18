vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require('mini.ai').setup()

require('mini.cmdline').setup({
  autocomplete = {
    enable = false,
  },
})

require('mini.completion').setup()

require('mini.diff').setup({
  view = {
    style = "number",
  },
})

require('mini.files').setup()

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlwght standalone “FIXME”, “HACK”, “TODO”, “NOTE”
    fixme     = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
    hack      = { pattern = 'HACK', group = 'MiniHipatternsHack' },
    todo      = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
    note      = { pattern = 'NOTE', group = 'MiniHipatternsNote' },

    -- Highlight hex color strings (`#RRGGBB`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.jump').setup()

local map = require('mini.map')
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diagnostic(),
    map.gen_integration.diff(),
  },

  window = {
    show_integration_count = false,
  },
})

require('mini.move').setup({
  mappings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",

    line_left = "<C-h>",
    line_down = "<C-j>",
    line_up = "<C-k>",
    line_right = "<C-l>",
  },
})

require('mini.operators').setup()
require('mini.pick').setup()
require('mini.splitjoin').setup()

require('mini.surround').setup({
  mappings = {
    add = '<leader>sa',       -- Add surrounding in Normal and Visual modes
    delete = '<leader>sd',    -- Delete surrounding
    find = '<leader>sf',      -- Find surrounding (to the right)
    find_left = '<leader>sF', -- Find surrounding (to the left)
    highlight = '<leader>sh', -- Highlight surrounding
    replace = '<leader>sr',   -- Replace surrounding
  },
})
