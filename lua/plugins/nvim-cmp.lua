return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded",
					-- NormalFloat so the menu keeps a solid background against the
					-- transparent buffer, PmenuSel to mark the selected row
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					scrollbar = true,
					col_offset = -3, -- line the icon column up with the text in the buffer
					side_padding = 1,
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
				}),
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				-- lazydev completions for the neovim lua api, skips the lsp source
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				-- three columns: the pictogram, the item itself, then the kind name
				fields = { "kind", "abbr", "menu" },
				format = function(_, item)
					-- cmp keeps its own CompletionItemKind table, so lspkind.init()
					-- never reaches it: look the pictogram up by hand instead
					local icon = lspkind.symbolic(item.kind) or ""

					if vim.fn.strchars(item.abbr) > 50 then
						item.abbr = vim.fn.strcharpart(item.abbr, 0, 50) .. "…"
					end

					item.menu = "  " .. item.kind
					item.kind = " " .. icon .. " "

					return item
				end,
			},
			-- shows the selected completion inline as you scroll the menu
			experimental = {
				ghost_text = { hl_group = "CmpGhostText" },
			},
		})

		-- dim the inline preview so it reads as a suggestion, not as real text
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
	end,
}
