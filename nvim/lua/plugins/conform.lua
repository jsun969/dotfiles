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
			-- clang-format reads .clang-format from the file's dir upwards, and
			-- falls back to its LLVM style when there is none.
			c = { "clang-format" },
			cpp = { "clang-format" },
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
