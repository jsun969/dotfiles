return {
	"OXY2DEV/markview.nvim",
	-- Upstream: do not lazy load it, it already attaches per buffer and lazy loading
	-- only delays the preview; also wants to load after the colorscheme (priority 1000).
	lazy = false,
	opts = {
		preview = {
			-- Raw markdown on the line the cursor is on, like render-markdown's anti-conceal.
			-- `hybrid_modes` is empty by default, so nothing is revealed while sitting on a line.
			hybrid_modes = { "n", "no", "c" },
			-- Reveal just the cursor line; keep the rendering of everything else (table borders etc.).
			linewise_hybrid_mode = true,
		},
	},
}
