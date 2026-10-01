local installed = {
	"lua",
	"vim",
	"vimdoc",
	"bash",
	"json",
	"toml",
	"yaml",
	"rust",
	"markdown",
	"diff",
	-- javascript owns .js/.jsx/.jsx+react; tsx owns .tsx/react; typescript owns .ts
	"javascript",
	"typescript",
	"tsx",
}

-- Installed for injections (markdown code fences, vim help); never owns a buffer.
local injected = { "markdown_inline" }

return {
	"nvim-treesitter/nvim-treesitter",
	-- Rewritten `main` branch: loads eagerly, needs `tree-sitter-cli` + a C compiler.
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Async and skipped once installed; lands in `stdpath("data")/site`.
		require("nvim-treesitter").install(vim.list_extend(vim.deepcopy(installed), injected))

		-- `main` does not enable highlighting by itself. `*` covers the plugin's own
		-- filetype aliases (bash->sh, json->jsonc, diff->gitdiff). The pcall is for the
		-- first launch, when the parser may still be compiling.
		-- No fold/indent overrides: keep `foldmethod=manual` and the ftplugin indenter.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
