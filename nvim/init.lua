vim.opt.number = true
vim.opt.relativenumber = true

-- 24-bit color for the colorscheme (nvim auto-detects too, this is explicit).
vim.opt.termguicolors = true

-- integrate w/ system clipboard
vim.opt.clipboard = "unnamedplus"

-- indent with real tabs, 4 columns wide
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require("config.lazy")
