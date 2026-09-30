return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- Load first: everything else picks its highlight groups up.
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
