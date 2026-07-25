vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.c", "*.h" },
    group = vim.api.nvim_create_augroup("c_formatter_42", { clear = true }),
    callback = function(args)
        local view = vim.fn.winsaveview() -- remember cursor/scroll
        vim.fn.system({ "c_formatter_42", args.file })
        if vim.v.shell_error ~= 0 then
            vim.notify("c_formatter_42 failed", vim.log.levels.WARN)
            return
        end
        vim.cmd("silent! edit!") -- reload formatted file
        vim.fn.winrestview(view)
    end,
})
