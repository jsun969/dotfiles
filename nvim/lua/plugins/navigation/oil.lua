-- Edit the filesystem like a buffer.

return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- Oil owns directory buffers (e.g. `nvim .`); nvim-tree stays a sidebar.
		default_file_explorer = true,
		keymaps = {
			-- Mac "delete" key sends <BS>.
			["<BS>"] = { "actions.parent", mode = "n" },
		},
		view_options = {
			show_hidden = true,
		},
	},
}
