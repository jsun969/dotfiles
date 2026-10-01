-- Format current buffer. <leader>f (normal/visual). stylua for lua.


return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
	},
}
