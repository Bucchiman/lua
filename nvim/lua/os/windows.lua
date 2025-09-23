#!/usr/bin/env lua
--
-- FileName:     windows
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2025-09-15 22:06:33
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--



local M = {}

function M:init()
    -- table.insert(M.options, {
    --     shell = "powershell"
    -- })
    -- M.options[shell] = "powershell"
    -- vim.opt.shell = "powershell"
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
    vim.opt.shellxquote = ''
end

M:init()
