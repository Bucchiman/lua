#!/usr/bin/env lua
--
-- FileName:     macos
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2025-11-16 14:58:25
-- LastModified: 2025-11-16 14:59:42
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


local M = {}

function M:init()
    vim.opt.shell = "zsh"
    vim.opt.shellcmdflag = "-l -c"
end



