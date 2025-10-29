return {
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				bold = true,
				italics = true,
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = {},
				typeStyle = {},
				transparent = true,
				terminalColors = true,
				background = {
					dark = "ink",
					light = "ink",
				},
				foreground = "saturated",
				overrides = function()
					return {
						TelescopePromptBorder = { fg = "#C5C9C7" },
						TelescopeResultsBorder = { fg = "#C5C9C7" },
					}
				end,
			})

			vim.cmd.colorscheme("kanso")
		end,
	},
}
