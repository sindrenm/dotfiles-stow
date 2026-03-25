local gitLineage = require("gitlineage")
local jj = require("jj")

gitLineage.setup()

jj.setup({
  diff = {
    backend = "diffview"
  },
  cmd = {
    keymaps = {
      log = {
        select_next_revision = "]]",
        select_prev_revision = "[[",
      }
    },
    split = {
      width = 0.98,
      height = 0.95,
    },
  },
})
