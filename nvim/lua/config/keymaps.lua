-- Window nav/resize without the <C-w> prefix, so a key can be tapped repeatedly.
-- macOS claims <C-Left>/<C-Right> ("Move a space") and <C-Up>/<C-Down> (Mission
-- Control / Application windows) by default: uncheck those in System Settings >
-- Keyboard > Keyboard Shortcuts > Mission Control or the keys never reach nvim.
-- Required from init.lua after `vim.g.mapleader`, so `<leader>` expands to space.

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
