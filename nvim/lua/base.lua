#!/usr/bin/env lua
--
-- FileName:     common
-- Author:       8ucchiman
-- CreatedDate:  2023-04-02 14:51:17 +0900
-- LastModified: 2025-03-15 10:38:43
-- Reference:    8ucchiman.jp
--



local M = {}

function M:init()
    vim.cmd("autocmd!")

    vim.api.nvim_create_autocmd(
        "InsertLeave",           -- 挿入モードを抜ける時
        {
            pattern = "*",
            command = "set nopaste"
        }
    )

    vim.api.nvim_create_augroup("WorkingDirectory", { clear = true })
    vim.api.nvim_create_autocmd({"BufEnter"}, {
        pattern = {"*.*"}, 
        callback = function()
            local path = vim.fn.expand('%:h')..'/'
            path = "cd "..path
            print(path)
            vim.api.nvim_command(path)
        end,
        group = "WorkingDirectory",
    })

    vim.opt.formatoptions:append { 'r' }
    -- local terminal_buffer = vim.api.nvim_create_buf(false, true)
    -- vim.api.nvim_buf_call(terminal_buffer, function ()
    --     vim.cmd("terminal")
    -- end)


    local default_path = vim.fn.expand("~")
    vim.api.nvim_set_current_dir(default_path)


    local home_dir = os.getenv('HOME')
    if home_dir == nil then
        home_dir = os.getenv('UserProfile')
    end
    local nvim_qt_dir = os.getenv('NVIM_QT_RUNTIME_PATH')

    vim.opt.runtimepath:append('$HOME/.config/local')
    pcall(require, "local")

    -- if Bmods.file_exists(home_dir .. "/.config/local/lua/local.lua") then
    --     vim.opt.runtimepath:append('$HOME/.config/local')
    --     require("local")
    -- end

end


M:init()
