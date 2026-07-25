return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- oxocarbon has no setup(), it is a plain colorscheme: the background
            -- is left alone on purpose, neovim asks the terminal for it and sets
            -- it, so light/dark follows the terminal like catppuccin "auto" did

            -- keep the transparent background the old theme was configured with
            local function clear_bg(group)
                local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
                if next(hl) then
                    hl.bg, hl.ctermbg = nil, nil
                    vim.api.nvim_set_hl(0, group, hl)
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("OxocarbonTransparent", { clear = true }),
                pattern = "oxocarbon",
                callback = function()
                    -- buffer background only: floats (completion, hover, telescope)
                    -- keep oxocarbon's own background so they stay readable
                    for _, group in ipairs({
                        "Normal",
                        "NormalNC",
                        "SignColumn",
                        "EndOfBuffer",
                        "LineNr",
                        "FoldColumn",
                    }) do
                        clear_bg(group)
                    end

                    -- oxocarbon draws borders in near-black, meant to blend into a
                    -- solid float. lift the line so rounded borders are actually
                    -- visible, keeping the background equal to NormalFloat so the
                    -- border and the float body read as one surface
                    local float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
                    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#525252", bg = float.bg })
                end,
            })

            vim.cmd.colorscheme("oxocarbon")
        end,
    },
}
