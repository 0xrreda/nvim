vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false

-- vim.opt.clipboard = "unnamedplus"

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")

vim.keymap.set("n", "<leader>cs", ":nohl<CR>", {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})

vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>y", '"+y', {})

-- vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", {})
vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", {})
vim.keymap.set("n", "<leader>hd", ":lua require('harpoon.mark').rm_file()<CR>", {})
vim.keymap.set("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", {})
vim.keymap.set("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", {})
