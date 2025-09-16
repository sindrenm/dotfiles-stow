-- Used by noice.nvim
vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })

require('notify').setup({
  render = "default",
  background_colour = "#000000",
  top_down = false,
  fps = 120,
})
