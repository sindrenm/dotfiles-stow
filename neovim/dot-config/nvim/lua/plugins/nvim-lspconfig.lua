vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({
  "jsonls",
  "kotlin_lsp",
  "lua_ls",
  "nil_ls",
  "qmlls",
  "rust_analyzer",
  "taplo",
  "yamlls",
})

-- The QML LSP command on Arch is `qmlls6`, not `qmlls`,
-- which nvim-lspconfig assumes by default
vim.lsp.config("qmlls", {
  cmd = { "qmlls6" },
})
