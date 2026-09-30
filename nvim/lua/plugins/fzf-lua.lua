return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "FzfLua",
	opts = function()
		-- Resolved at setup (first use), not at spec-scan time, so the plugin stays lazy.
		local actions = require("fzf-lua").actions
		return {
			fzf_colors = true,
			defaults = { formatter = "path.dirname_first" },
			winopts = { width = 0.8, height = 0.8, row = 0.5, col = 0.5 },
			files = {
				cwd_prompt = false,
				-- Git status indicators (M/A/D/R/?? ...) in front of each path.
				git_icons = true,
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
		}
	end,
	keys = {
		-- Global picks; `<leader>e` stays nvim-tree, `<leader>f` stays conform.
		{ "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
		-- git
		{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git Branches" },
		{ "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },
		-- search
		{ "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
		{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word" },
		{ "<leader>sW", "<cmd>FzfLua grep_visual<cr>", mode = "x", desc = "Selection" },
	},
}
