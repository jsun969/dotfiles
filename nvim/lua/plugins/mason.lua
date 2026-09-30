return {
	-- language servers: installs and auto-enables them
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- lspconfig server names, not mason names
			ensure_installed = { "lua_ls" },
			-- automatic_enable enables every Mason-installed package that has a
			-- matching lspconfig server. nvim-lspconfig now ships `stylua`
			-- (cmd = stylua --lsp), so installing the formatter via
			-- mason-tool-installer below would also attach it as a second Lua
			-- server, duplicating what conform.nvim already does.
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
