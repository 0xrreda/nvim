return {
	{
		-- Native treesitter highlighting & folding (no plugin needed for Neovim 0.12+)
		-- Parser installer to replace nvim-treesitter
		"romus204/tree-sitter-manager.nvim",
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = "all", -- or list specific languages
			})

			-- Enable highlighting for all filetypes natively
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			require("ufo").setup({})
		end,
	},
}
