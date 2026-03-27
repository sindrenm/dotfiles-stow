local hunk = require("hunk")
local jj = require("jj")

hunk.setup(
  {
    keys = {
      global = {
        quit = { "q" },
        accept = { "<S-Cr>" },
        focus_tree = { "<leader>e" },
      },

      tree = {
        expand_node = { "l", "<Right>" },
        collapse_node = { "h", "<Left>" },

        open_file = { "<Cr>" },

        toggle_file = { "<Space>" },
      },

      diff = {
        toggle_line = { "a" },
        toggle_line_pair = { "<C-a>" },
        toggle_hunk = { "<S-a>" },

        prev_hunk = { "[[" },
        next_hunk = { "]]" },

        -- Jump between the left and right diff view
        toggle_focus = { "<Tab>" },
      },
    },
  }
)

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
