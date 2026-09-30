vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

-- indent with real tabs, 4 columns wide
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require("config.lazy")
