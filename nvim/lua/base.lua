#!/usr/bin/env lua
--
-- FileName:     lua/base
-- Author: 8ucchiman
-- CreatedDate:  2023-04-02 14:51:17 +0900
-- LastModified: 2023-04-02 14:51:53 +0900
-- Reference: 8ucchiman.jp
--


vim.cmd("autocmd!")

vim.api.nvim_create_autocmd(
    "InsertLeave",           -- 挿入モードを抜ける時
    {
        pattern = "*",
        command = "set nopaste"
    }
)

-- vim.g.ft_ignore_pat = '\\.\\(Z\\|gz\\|bz2\\|zip\\|tgz\\)$'
-- vim.g.ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

 -- vim.api.nvim_create_augroup("WorkingDirectory", { clear = true })
 -- vim.api.nvim_create_autocmd({"BufEnter"}, {
 --     pattern = {"*.*"}, 
 --     callback = function()
 --         local path = vim.fn.expand('%:h')..'/'
 --         path = "cd "..path
 --         print(path)
 --         vim.api.nvim_command(path)
 --     end,
 --     group = "WorkingDirectory",
 -- })

vim.opt.formatoptions:append { 'r' }
-- local terminal_buffer = vim.api.nvim_create_buf(false, true)
-- vim.api.nvim_buf_call(terminal_buffer, function ()
--     vim.cmd("terminal")
-- end)
