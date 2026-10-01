-- Statusline: mode, branch, diagnostics, encoding/filetype, progress, location.


return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			-- Block look: no powerline separator glyphs.
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				-- Nerd Font octicons: x-circle / alert / info / light-bulb.
				{
					"diagnostics",
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
			},
			-- encoding + filetype only: no fileformat (its "linux" icon said nothing useful).
			lualine_x = { "encoding", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
