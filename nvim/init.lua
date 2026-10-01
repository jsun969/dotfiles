-- Before anything maps a key: `<leader>` in a mapping is expanded at definition
-- time, so this must be set before init.lua's own keymaps (and before lazy.nvim).
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-- splits open right/below, keep the viewport on split, don't squeeze panes
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.winminwidth = 5

-- one global statusline (lualine) and a quick which-key popup on <C-w>/<leader>
vim.opt.laststatus = 3
vim.opt.timeoutlen = 300

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

-- Window keymaps; see lua/config/keymaps.lua.
require("config.keymaps")

require("config.lazy")

-- After lazy.nvim, so nvim-lspconfig's `lsp/` configs are on the runtimepath.
require("config.lsp")
