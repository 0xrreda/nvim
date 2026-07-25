return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            "                                                             ",
            " ███                                           █████         ",
            "░███                                          ░░███          ",
            "░███ █████ █████  █████   ██████   ██████   ███████   ██████ ",
            "░███░░███ ░░███  ███░░   ███░░███ ███░░███ ███░░███  ███░░███",
            "░███ ░███  ░███ ░░█████ ░███ ░░░ ░███ ░███░███ ░███ ░███████ ",
            "░░░  ░░███ ███   ░░░░███░███  ███░███ ░███░███ ░███ ░███░░░  ",
            " ███  ░░█████    ██████ ░░██████ ░░██████ ░░████████░░██████ ",
            "░░░   ░░░░░    ░░░░░░   ░░░░░░   ░░░░░░   ░░░░░░░░  ░░░░░░   ",
            "                                                             ",
            "                                                             ",
        }
        dashboard.section.buttons.val = {
            dashboard.button("b", "  > Browse files", ":lua require('oil').open()<CR>"),
            dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        }
        alpha.setup(dashboard.opts)
    end,
}
