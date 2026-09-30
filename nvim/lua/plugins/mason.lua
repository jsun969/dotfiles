return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- lspconfig server names, not mason names
			ensure_installed = { "lua_ls" },
			-- nvim-lspconfig also ships a `stylua` server; auto-enable would attach it
			-- next to conform's CLI, so format via conform only.
			automatic_enable = {
				exclude = { "stylua" },
			},
		},
	},
	-- non-lsp tools (formatters, linters). mason-lspconfig rejects these names.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
			},
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
