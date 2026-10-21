-- Installs LSP servers (lua_ls, ts_ls, eslint, oxlint, pyright, just-lsp, gopls) and CLI tools (stylua, ruff, goimports, gofumpt).
-- eslint and oxlint only attach in projects that configure them (eslint.config.* / .eslintrc*,
-- .oxlintrc.json / oxlint in package.json), so each repo picks its own linter.
-- pyright comes from npm, so node must be on PATH (mason fetches it via its npm package).


return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- lspconfig server names, not mason names
			ensure_installed = { "lua_ls", "ts_ls", "eslint", "oxlint", "pyright", "just", "gopls" },
			-- nvim-lspconfig also ships a `stylua` server; auto-enable would attach it
			-- next to conform's CLI, so format via conform only.
			automatic_enable = {
				exclude = { "stylua" },
			},
		},
	},
	-- non-lsp tools (formatters, linters). mason-lspconfig rejects these names.
	-- `ruff` is also an lspconfig server name (`ruff server`), so installing it here
	-- lets automatic_enable attach it for lint diagnostics; conform drives formatting.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"oxfmt",
				"ruff",
				"goimports",
				"gofumpt",
			},
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
