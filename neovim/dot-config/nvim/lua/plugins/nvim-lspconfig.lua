vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({
  "jsonls",
  "kotlin_lsp",
  "lua_ls",
  "nil_ls",
  "rust_analyzer",
  "taplo",
  "yamlls",
})
