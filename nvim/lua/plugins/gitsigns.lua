-- Git hunk signs, inline line blame, stage/reset hunks.


return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signcolumn = true,
		-- Blame of the cursor line, drawn as virtual text at end of line
		-- (current_line_blame_opts.virt_text_pos defaults to "eol").
		current_line_blame = true,
		current_line_blame_opts = {
			-- Default is 1000 ms; lower so the blame shows up as soon as you settle.
			delay = 150,
		},
		on_attach = function(bufnr)
			-- gitsigns ships no mappings of its own.
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Hunk navigation.
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next git hunk")
			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Previous git hunk")

			-- Stage / reset, normal and visual (line range) variants.
			map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk (selection)")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk (selection)")
			map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

			-- Inspect.
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>gb", gs.blame_line, "Blame line")
			map("n", "<leader>gd", gs.diffthis, "Diff this against index")
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, "Diff this against last commit")

			-- Toggles.
			map("n", "<leader>gtb", gs.toggle_current_line_blame, "Line blame")
			map("n", "<leader>gtw", gs.toggle_word_diff, "Word diff")
			map("n", "<leader>gts", gs.toggle_signs, "Signs")
			map("n", "<leader>gtd", gs.toggle_deleted, "Deleted lines")
		end,
	},
}
