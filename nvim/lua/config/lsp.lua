-- LSP servers that mason does not manage.
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

-- nixd: completion for nixpkgs and home-manager options from the dotfiles flake.
local dotfiles = vim.fs.dirname(vim.fs.normalize(vim.fn.resolve(vim.fn.stdpath("config"))))
local hm_flake = vim.fs.joinpath(dotfiles, "nix", "home-manager")
local get_flake = ('(builtins.getFlake "%s")'):format(hm_flake)
vim.lsp.config("nixd", {
	settings = {
		nixd = {
			nixpkgs = { expr = ("import %s.inputs.nixpkgs { }"):format(get_flake) },
			options = {
				home_manager = { expr = ("%s.homeConfigurations.deck.options"):format(get_flake) },
			},
		},
	},
})

vim.lsp.enable("nixd")

-- rust-analyzer from PATH (rustup component, distro or nix package), so it
-- matches the installed toolchain; clippy on save.
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
		},
	},
})

vim.lsp.enable("rust_analyzer")

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
