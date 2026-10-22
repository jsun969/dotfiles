-- Fuzzy picker for files, grep, buffers, git, LSP symbols.


return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "FzfLua",
	opts = function()
		-- Resolved at setup (first use), not at spec-scan time, so the plugin stays lazy.
		local actions = require("fzf-lua").actions
		return {
			fzf_colors = {
				true, -- keep the rest of the theme mapping
				-- No background band behind the selected row.
				["bg+"] = { "bg", { "FzfLuaFzfNormal", "Normal" } },
			},
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
	config = function(_, opts)
		local fzf = require("fzf-lua")
		-- A `config` function suppresses lazy's automatic setup(opts) call.
		fzf.setup(opts)
		-- Hand vim.ui.select (LSP code actions, plugin prompts) to fzf-lua.
		-- Undo at runtime with `:FzfLua deregister_ui_select`.
		fzf.register_ui_select()
		-- Selection bar (pointer; marker/spinner link to it): theme color, not
		-- the `Special` pink.
		vim.api.nvim_set_hl(0, "FzfLuaFzfPointer", { link = "Comment" })
	end,
	keys = {
		-- Global picks; `<leader>e` stays nvim-tree, `<leader>f` stays conform.
		{ "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
		-- git
		{ "<leader>sgs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
		{ "<leader>sgc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
		{ "<leader>sgb", "<cmd>FzfLua git_branches<cr>", desc = "Branches" },
		{ "<leader>sgS", "<cmd>FzfLua git_stash<cr>", desc = "Stash" },
		{ "<leader>sgh", "<cmd>FzfLua git_hunks<cr>", desc = "Hunks" },
		-- lsp
		{ "<leader>sls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>slS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace Symbols" },
		{ "<leader>sld", "<cmd>FzfLua lsp_definitions<cr>", desc = "Definitions" },
		{ "<leader>slD", "<cmd>FzfLua lsp_declarations<cr>", desc = "Declarations" },
		{ "<leader>slr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
		{ "<leader>sli", "<cmd>FzfLua lsp_implementations<cr>", desc = "Implementations" },
		{ "<leader>slt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "Type Definitions" },
		{ "<leader>slc", "<cmd>FzfLua lsp_incoming_calls<cr>", desc = "Incoming Calls" },
		{ "<leader>slC", "<cmd>FzfLua lsp_outgoing_calls<cr>", desc = "Outgoing Calls" },
		{ "<leader>sla", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code Actions" },
		-- search
		{ "<leader>s/", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Buffer" },
		{ "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
		{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
		{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sL", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word" },
		{ "<leader>sW", "<cmd>FzfLua grep_visual<cr>", mode = "x", desc = "Selection" },
	},
}
