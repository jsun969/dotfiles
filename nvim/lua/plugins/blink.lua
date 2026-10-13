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
		-- No completion in markdown.
		enabled = function()
			return vim.bo.filetype ~= "markdown"
		end,
		keymap = {
			-- VS Code-like: <CR> accepts (newline when the menu is hidden); <Tab> accepts
			-- too but jumps snippet placeholders first.
			preset = "enter",
			-- VS Code's Ctrl+Space: trigger the suggestion list, nothing else. The
			-- `enter` preset instead cycles menu -> show docs -> hide docs on each
			-- press (`show_documentation`/`hide_documentation` only run once `show`
			-- returns false), so override it. No `fallback`: nvim's native <C-space>
			-- (i_CTRL-@, insert the text you inserted last time you left insert mode)
			-- stays shadowed, matching VS Code, which never inserts text here. Docs
			-- still auto-show and page with <C-b>/<C-f>.
			["<C-space>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						return true -- already open: triggerSuggest is a no-op, not a docs toggle
					end
				end,
				"show",
			},
			["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			-- <C-j>/<C-k> navigate the menu, as an alias for <C-n>/<C-p> (still bound).
			-- blink sets these buffer-locally for insert/select/term mode only, so the
			-- normal-mode window nav (<C-j>/<C-k> in config/keymaps.lua) is unaffected.
			-- With the menu hidden the mapping returns early and `fallback` restores
			-- nvim's own key: <C-j> newline, <C-k> digraph. While the menu is open they
			-- only navigate -- retyping or <C-e> leaves the menu to reach the native key.
			["<C-j>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						cmp.select_next()
						return true -- swallow at the last item instead of falling back
					end
				end,
				"fallback",
			},
			-- The `enter` preset gives <C-k> to signature help; keep that, but only while
			-- the menu is closed, so the key navigates while completing. (Signature help
			-- still auto-shows; this is just the manual toggle.)
			["<C-k>"] = {
				function(cmp)
					if cmp.is_menu_visible() then
						cmp.select_prev()
						return true
					end
				end,
				"show_signature",
				"hide_signature",
				"fallback",
			},
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
		-- parameter hints. <C-b>/<C-f> scroll the docs; <C-k> toggles signature
		-- help while the menu is closed (see keymap above).
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
