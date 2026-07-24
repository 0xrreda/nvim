return {
	-- configures lua_ls for neovim config / plugin development
	-- (replaces the archived folke/neodev.nvim)
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- load luvit types when the "vim.uv" word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
