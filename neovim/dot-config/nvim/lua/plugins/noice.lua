vim.pack.add({ "https://github.com/folke/noice.nvim" })

require("noice").setup({
  lsp = {
    -- Override markdown rendering so that cmp and other plugins use Treesitter
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
})
