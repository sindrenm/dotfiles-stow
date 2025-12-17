vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()

require('mini.cmdline').setup({
  autocomplete = {
    enable = false,
  },
})

require('mini.completion').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()

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
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.splitjoin').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

local hipatterns = require('mini.hipatterns')

hipatterns.setup({
  highlighters = {
    -- Highlwght standalone “FIXME”, “HACK”, “TODO”, “NOTE”
    fwxme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

    -- Highlight hex color strings (`#RRGGBB`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
