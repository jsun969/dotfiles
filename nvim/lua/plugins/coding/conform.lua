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
			-- goimports fixes the import block, then gofumpt applies stricter gofmt.
			go = { "goimports", "gofumpt" },
			-- oxfmt when the project has an oxfmt config, else prettier (which reads
			-- .prettierrc* itself). conform resolves node_modules/.bin first, then
			-- PATH, i.e. mason's bin.
			javascript = { "oxfmt", "prettier", stop_after_first = true },
			javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
			typescript = { "oxfmt", "prettier", stop_after_first = true },
			typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
			vue = { "oxfmt", "prettier", stop_after_first = true },
			css = { "oxfmt", "prettier", stop_after_first = true },
			scss = { "oxfmt", "prettier", stop_after_first = true },
			json = { "oxfmt", "prettier", stop_after_first = true },
			jsonc = { "oxfmt", "prettier", stop_after_first = true },
		},
		formatters = {
			-- conform's builtin oxfmt has no condition, so it would win everywhere;
			-- only use it when an oxfmt config sits above the file.
			oxfmt = {
				condition = function(_, ctx)
					return vim.fs.root(ctx.dirname, { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }) ~= nil
				end,
			},
		},
	},
}
