return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- inline diagnostic text, shown to the right of the offending line
		local virtual_text = {
			spacing = 4,
			prefix = "●",
			source = "if_many",
		}

		vim.diagnostic.config({
			virtual_text = virtual_text,
			severity_sort = true,
			underline = true,
			float = {
				border = "rounded",
				source = true,
			},
			-- Change the Diagnostic symbols in the sign column (gutter)
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- toggle the inline text off when it gets in the way (trouble, <leader>xw,
		-- still lists everything either way)
		keymap.set("n", "<leader>dv", function()
			local shown = vim.diagnostic.config().virtual_text ~= false
			vim.diagnostic.config({ virtual_text = not shown and virtual_text or false })
			vim.notify("diagnostic virtual text " .. (shown and "off" or "on"))
		end, { desc = "Toggle inline diagnostics" })

		-- used to enable autocompletion (assign to every lsp server config)
		vim.lsp.config("*", {
			capabilities = cmp_nvim_lsp.default_capabilities(),
		})

		vim.lsp.config("ts_ls", {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/node_modules/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
		})

		-- configure emmet language server
		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "css", "sass", "scss", "less", "vue" },
		})

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- servers installed through mason are enabled automatically by
		-- mason-lspconfig v2 (automatic_enable), picking up the configs above
	end,
}
