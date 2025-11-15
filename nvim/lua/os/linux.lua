#!/usr/bin/env lua
--
-- FileName:     linux
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2025-09-15 22:00:17
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--



print("linux")

local M = {}

function M:init()
    vim.opt.shell = "zsh"
    vim.opt.shellcmdflag = "-l -c"
end

M:init()
