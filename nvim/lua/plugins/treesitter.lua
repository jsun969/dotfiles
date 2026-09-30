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
}

-- Injection-only grammars: installed so host languages (markdown code fences, vim
-- help blocks) can parse their embedded regions, but they never own a buffer.
local injected = { "markdown_inline" }

return {
	"nvim-treesitter/nvim-treesitter",
	-- The rewritten `main` branch feeds Neovim's built-in treesitter features and
	-- does not support lazy-loading, so it has to load eagerly. Needs a C compiler
	-- and `tree-sitter-cli` on $PATH (see README; that is NOT the `tree-sitter` lib).
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- Fire and forget: every entry is a no-op once its parser is installed, and the
		-- async install never blocks startup. Parsers and queries land in
		-- `stdpath("data")/site`, which the plugin prepends to the runtimepath.
		ts.install(vim.list_extend(vim.deepcopy(installed), injected))

		-- On `main` nothing is enabled automatically: highlighting and folding are
		-- opt-in per buffer (see :h treesitter-highlight). Pattern `*` rather than a
		-- filetype list because the plugin registers grammar aliases itself
		-- (`bash` -> sh, `json` -> jsonc, `diff` -> gitdiff, `markdown` -> pandoc),
		-- and `vim.treesitter.start()` resolves the language from the filetype.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				-- Fails when the filetype has no grammar, or the parser is still being
				-- compiled on the very first launch. Fall back to regex syntax.
				if not pcall(vim.treesitter.start) then
					return
				end

				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
			end,
		})

		-- Indentation is deliberately left to each filetype plugin: upstream labels the
		-- treesitter indent engine experimental, and ftplugins (lua, vim) assign
		-- 'indentexpr' after FileType fires, so an autocmd assignment gets overwritten.
	end,
}
