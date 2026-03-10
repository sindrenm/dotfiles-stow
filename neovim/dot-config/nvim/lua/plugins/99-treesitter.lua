local ts = require("nvim-treesitter")

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

vim.api.nvim_create_augroup("TreesitterAutoHighlight", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "TreesitterAutoHighlight",
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    local ok, _ = pcall(vim.treesitter.start, bufnr, filetype)

    if ok then
      vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
