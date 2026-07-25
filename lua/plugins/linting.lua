return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters = {
                c_formatter_42 = {
                    command = "c_formatter_42",
                    stdin = true,
                },
            },
            formatters_by_ft = {
                lua = { "stylua" },
                py = { "ruff" },
                c = { "c_formatter_42" },
            },
            format_on_save = function(bufnr)
                return {
                    -- never let clangd format C files, c_formatter_42 owns them
                    lsp_format = vim.bo[bufnr].filetype == "c" and "never" or "fallback",
                    async = false,
                    timeout_ms = 2500,
                }
            end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_format = vim.bo.filetype == "c" and "never" or "fallback",
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
