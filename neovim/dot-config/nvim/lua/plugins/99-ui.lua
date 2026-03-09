local hipatterns = require("mini.hipatterns")
local icons = require("mini.icons")
local indentBlankLine = require("ibl")
local kittyScrollback = require("kitty-scrollback")

vim.cmd.colorscheme "catppuccin"

kittyScrollback.setup()

indentBlankLine.setup()

icons.setup()
icons.mock_nvim_web_devicons()

hipatterns.setup({
  highlighters = {
    fixme     = { pattern = "FIXME", group = "MiniHipatternsFixme" },
    hack      = { pattern = "HACK", group = "MiniHipatternsHack" },
    todo      = { pattern = "TODO", group = "MiniHipatternsTodo" },
    note      = { pattern = "NOTE", group = "MiniHipatternsNote" },

    -- Highlight hex color strings ("#RRGGBB") using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_lines = false,
  virtual_text = { prefix = '!', },
})
