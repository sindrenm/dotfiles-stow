local twilight = require("twilight")

twilight.setup({
  context = 0,
  expand = {
    "paragraph",
    "fenced_code_block",
    "list",
  }
})
