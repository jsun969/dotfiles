-- LSP servers that mason does not manage.
-- clangd ships with the Xcode command line tools (brew llvm also provides it, and
-- that copy wins on PATH), so there is nothing to install -- just configure and
-- enable it. nvim-lspconfig supplies the base client config.
vim.lsp.config("clangd", {
	-- LazyVim's flags: background index, clang-tidy diagnostics, IWYU include
	-- fixes, detailed completion, llvm style when there are no project flags.
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
})

vim.lsp.enable("clangd")
