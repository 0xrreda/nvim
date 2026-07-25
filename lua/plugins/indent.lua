return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        require("ibl").setup({
            indent = {
                highlight = "IblIndent",
            },
            scope = {
                enabled = true,
                highlight = "IblScope",
            },
        })
    end,
}
