vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight only the current line's number, not the whole line (CursorLineNr).
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- 24-bit color for the colorscheme (nvim auto-detects too, this is explicit).
vim.opt.termguicolors = true

-- integrate w/ system clipboard
vim.opt.clipboard = "unnamedplus"

-- Case-insensitive search and flash.nvim jumps (flash reads 'ignorecase' directly).
-- 'smartcase' makes an uppercase query case-sensitive again, for flash as well as `/`.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent with real tabs, 4 columns wide
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Nerd Font octicons for the inline diagnostic prefix (same set as lualine).
local diag_icons = {
	[vim.diagnostic.severity.ERROR] = "",
	[vim.diagnostic.severity.WARN] = "",
	[vim.diagnostic.severity.INFO] = "",
	[vim.diagnostic.severity.HINT] = "",
}

-- Diagnostics: underline + inline message, no sign-column glyphs.
vim.diagnostic.config({
	signs = false,
	underline = true,
	virtual_text = {
		prefix = function(d)
			return diag_icons[d.severity]
		end,
	},
})

require("config.lazy")
