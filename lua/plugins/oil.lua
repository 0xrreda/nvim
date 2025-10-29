return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return name == ".git"
				end,
			},
			float = {
				padding = 2,
				max_width = 0.5,
				max_hight = 1,
				border = "rounded",
				win_options = {
					winhighlight = "FloatBorder:OilFloatBorder,FloatTitle:OilFloatTitle",
				},
			},
		})

		vim.keymap.set("n", "ef", ":lua require('oil').toggle_float()<CR>", { desc = "Telescope find files" })
		vim.api.nvim_set_hl(0, "OilFloatBorder", { fg = "#C5C9C7", bg = "#14171d" })
		vim.api.nvim_set_hl(0, "OilFloatTitle", { fg = "#8ba4b0", bg = "#14171d", bold = true })
	end,
}
