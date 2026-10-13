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
			desc = "Format",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- ruff format reads the project's pyproject.toml / ruff.toml itself and
			-- falls back to its defaults when there is none. Same binary also ships
			-- `ruff server`, which mason auto-enables for lint diagnostics.
			python = { "ruff_format" },
			-- clang-format reads .clang-format from the file's dir upwards, and
			-- falls back to its LLVM style when there is none.
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- conform's builtin `just` formatter rewrites the justfile in place via
			-- `just --fmt --unstable -f $FILENAME`; just itself is the only formatter.
			just = { "just" },
			-- prettier reads the project's .prettierrc* itself (conform resolves
			-- node_modules/.bin/prettier first, then PATH, i.e. mason's bin).
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
		},
	},
}
