return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the main branch does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            local available = ts.get_available()

            local function enable(buf, lang)
                if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
                    return
                end
                if vim.treesitter.query.get(lang, "indents") then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            -- The main branch dropped `nvim-treesitter.configs`, so highlight, indent and
            -- auto_install are wired up by hand on FileType
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang then
                        return
                    end
                    if vim.list_contains(ts.get_installed("parsers"), lang) then
                        enable(args.buf, lang)
                    elseif vim.list_contains(available, lang) then
                        ts.install(lang):await(function()
                            vim.schedule(function()
                                enable(args.buf, lang)
                            end)
                        end)
                    end
                end,
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            require("ufo").setup({})
        end,
    },
}
