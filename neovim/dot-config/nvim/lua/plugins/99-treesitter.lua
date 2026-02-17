local ts = require("nvim-treesitter")

-- Automatically start tree-sitter for all supported languages
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local bufnr = args.buf
    local lang = vim.bo[bufnr].filetype

    -- Check if a parser actually exists for this language before starting.
    -- This prevents errors on unsupported file types.
    local ok, _ = pcall(vim.treesitter.get_parser, bufnr, lang)

    if ok then
      vim.treesitter.start(bufnr, lang)
    end
  end,
})

ts.install({
  "css",
  "csv",
  "desktop",
  "diff",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "gpg",
  "haskell",
  "html",
  "http",
  "ini",
  "java",
  "json",
  "json5",
  "kdl",
  "kotlin",
  "llvm",
  "lua",
  "luadoc",
  "markdown",
  "nix",
  "nu",
  "passwd",
  "pem",
  "python",
  "regex",
  "ruby",
  "rust",
  "sql",
  "ssh_config",
  "swift",
  "toml",
  "typescript",
  "tsv",
  "tsx",
  "typst",
  "udev",
  "xml",
  "xresources",
  "yaml",
})
