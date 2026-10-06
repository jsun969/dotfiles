-- Colorscheme. Loaded first so everything else uses its highlights.


return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- Load first: everything else picks its highlight groups up.
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
		-- Theme default (crust) is darker than the bg, so the dividers vanish.
		vim.api.nvim_set_hl(0, "WinSeparator", { link = "NonText" })
	end,
}
