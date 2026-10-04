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
		"--function-arg-placeholders=0",
		"--fallback-style=llvm",
	},
})

vim.lsp.enable("clangd")

-- nvim only ships the `gr*` LSP defaults, so hover and goto need keys. Buffer
-- local, set on attach, so they never shadow `K`/`gd` in buffers without a server.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover (full docs)")
		map("gd", vim.lsp.buf.definition, "Goto definition")
		map("gD", vim.lsp.buf.declaration, "Goto declaration")
		map("gI", vim.lsp.buf.implementation, "Goto implementation")
		map("gy", vim.lsp.buf.type_definition, "Goto type definition")
	end,
})
