-- Floating filename (filetype icon + git counts) in each window's top-right.


return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Resolved at setup (first use), not at spec-scan time, so the plugin stays lazy.
	opts = function()
		local helpers = require("incline.helpers")
		local devicons = require("nvim-web-devicons")

		-- Nerd Font octicons: diff-added / diff-modified / diff-removed.
		local git_icons = { added = " ", changed = " ", removed = " " }
		local git_groups = { added = "Added", changed = "Changed", removed = "Removed" }

		return {
			window = {
				padding = 0,
				margin = { horizontal = 0 },
			},
			render = function(props)
				local name = vim.api.nvim_buf_get_name(props.buf)
				local filename = vim.fn.fnamemodify(name, ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color =
					devicons.get_icon_color(filename, vim.fn.fnamemodify(name, ":e"), { default = true })

				-- Git changes: octicons, counts from gitsigns.
				local function git_changes()
					local signs = vim.b[props.buf].gitsigns_status_dict
					if not signs then
						return {}
					end
					local labels = {}
					for _, kind in ipairs({ "added", "changed", "removed" }) do
						local n = tonumber(signs[kind])
						if n and n > 0 then
							labels[#labels + 1] = { git_icons[kind] .. n .. " ", group = git_groups[kind] }
						end
					end
					return labels
				end

				local res = {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
				}

				local changes = git_changes()
				if #changes > 0 then
					res[#res + 1] = { " │ " }
					res[#res + 1] = changes
				end

				res[#res + 1] = " "
				return res
			end,
		}
	end,
	-- Incline's redraw events do not include gitsigns' updates, and its debounce fires on the
	-- leading edge: the render triggered by opening a buffer usually beats gitsigns' async diff,
	-- so the git counts would only appear on the next cursor move / CursorHold (updatetime).
	-- Defer slightly so the update carrying the counts is the one that triggers the render.
	config = function(_, opts)
		require("incline").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "GitSignsUpdate",
			callback = function()
				vim.defer_fn(function()
					require("incline").refresh()
				end, 60)
			end,
		})
	end,
}
