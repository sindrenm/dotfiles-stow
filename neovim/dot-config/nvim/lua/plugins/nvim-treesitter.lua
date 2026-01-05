vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
  },
})

-- Automatically start treesitter for all supported languages
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local bufnr = args.buf
    local lang = vim.bo[bufnr].filetype

    -- Check if a parser actually exists for this language before starting.
    -- This prevents errors on unsupported filetypes.
    local ok, _ = pcall(vim.treesitter.get_parser, bufnr, lang)

    if ok then
      vim.treesitter.start(bufnr, lang)
    end
  end,
})

require("nvim-treesitter").install({
  "awk",
  "bash",
  "c_sharp",
  "cmake",
  "comment",
  "css",
  "csv",
  "desktop",
  "diff",
  "dockerfile",
  "dot",
  "ecma",
  "editorconfig",
  "fish",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "gpg",
  "graphql",
  "haskell",
  "html",
  "html_tags",
  "http",
  "hyprlang",
  "ini",
  "java",
  "javadoc",
  "javascript",
  "jq",
  "json",
  "json5",
  "jsx",
  "kdl",
  "kotlin",
  "latex",
  "llvm",
  "lua",
  "luadoc",
  "make",
  "nginx",
  "nix",
  "nu",
  "objc",
  "passwd",
  "pem",
  "powershell",
  "proto",
  "python",
  "regex",
  "ruby",
  "rust",
  "sql",
  "ssh_config",
  "svelte",
  "swift",
  "tmux",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "typst",
  "udev",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "xresources",
  "yaml",
})

require("nvim-treesitter-textobjects").setup()
