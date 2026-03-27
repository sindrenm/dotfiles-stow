local hunk = require("hunk")
local jj = require("jj")

hunk.setup()

jj.setup({
  diff = {
    backend = "diffview"
  },
  cmd = {
    keymaps = {
      log = {
        select_next_revision = "]]",
        select_prev_revision = "[[",
        undo = "u",
        redo = "<C-r>",
      }
    },
    split = {
      width = 0.98,
      height = 0.95,
    },
  },
})
