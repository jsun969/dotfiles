-- File tree sidebar with git status and modified markers.


return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		-- Expand the tree to the focused file on BufEnter (e.g. after fzf-lua opens it).
		update_focused_file = {
			enable = true,
			-- Keep the tree root at cwd; do not jump it to the file's directory.
			update_root = { enable = false },
		},
		filters = {
			-- show gitignored files
			git_ignored = false,
			-- ignore .git folder and .DS_Store
			custom = { "^\\.git$", "^\\.DS_Store$" },
		},
		modified = {
			enable = true,
			show_on_dirs = true,
		},
		renderer = {
			icons = {
				show = {
					modified = true,
				},
				glyphs = {
					git = {
						unstaged = "M",
						staged = "A",
						unmerged = "U",
						renamed = "R",
						untracked = "??",
						deleted = "D",
						ignored = "!",
					},
				},
			},
		},
	},
}
