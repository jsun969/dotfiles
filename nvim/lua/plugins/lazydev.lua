return {
	"folke/lazydev.nvim",
	-- Only needed for Lua buffers; it points LuaLS at the right workspace libraries.
	ft = "lua",
	opts = {
		library = {
			-- luv/library types, loaded once `vim.uv` appears in the buffer.
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
