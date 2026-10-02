-- Completion menu (LSP/buffer/path/snippets) + snippets.


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
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				-- Module names for `require(...)` / `---@module` in Lua files.
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		-- VS Code-like: docs panel beside the menu while navigating, plus
		-- parameter hints. <C-b>/<C-f> scroll the docs, <C-k> toggles signature.
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 150 },
		},
		signature = {
			enabled = true,
			window = { show_documentation = true },
		},
		fuzzy = { implementation = "rust" },
	},
}
