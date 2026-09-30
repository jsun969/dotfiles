return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"saghen/blink.lib",
	},
	-- builds the rust fuzzy matcher; use :Lazy gb to rebuild
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = {
			-- VS Code-like: <CR> accepts (newline when the menu is hidden); <Tab> accepts
			-- too but jumps snippet placeholders first.
			preset = "enter",
			["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		fuzzy = { implementation = "rust" },
	},
}
