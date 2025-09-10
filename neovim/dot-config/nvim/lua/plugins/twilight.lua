vim.pack.add({ "https://github.com/folke/twilight.nvim" })

require("twilight").setup({
  context = 0,
  expand = {
    -- markdown
    "paragraph",
    "fenced_code_block",
    "list",
  }
})
