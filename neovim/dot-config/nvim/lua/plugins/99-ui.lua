local indentBlankLine = require("ibl")
local icons = require("mini.icons")
local hipatterns = require("mini.hipatterns")

vim.cmd.colorscheme "catppuccin"

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
