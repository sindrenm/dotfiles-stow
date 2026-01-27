local toggle_mini_files = function()
  if not MiniFiles.close() then MiniFiles.open() end
end

vim.keymap.set("n", "-", toggle_mini_files)
vim.keymap.set("n", "<leader>do", MiniDiff.toggle_overlay)
vim.keymap.set("n", "<leader>f", "<CMD>Pick files<CR>")
vim.keymap.set("n", "<leader>g", "<CMD>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", "<CMD>Pick help<CR>")
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>mm", MiniMap.toggle)
vim.keymap.set("n", "<leader>o", "<CMD>Outline<CR>")
vim.keymap.set("n", "<leader>pi", "<CMD>PasteImage<CR>")

local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "<leader>/", flash.jump, { desc = "Flash Jump" })
