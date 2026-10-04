-- Popup hints for pending keymaps.


return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>s", group = "Search" },
			{ "<leader>sg", group = "Git" },
			{ "<leader>sl", group = "LSP" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer-local keymaps",
		},
	},
}
