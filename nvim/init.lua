#!/usr/bin/env lua
--
-- FileName:     init
-- Author:       8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2025-03-15 11:36:01
-- Reference:    https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--               https://developer.jmatsuzaki.com/posts/get-file-name-in-vim/
--



function main()
    local uname = vim.loop.os_uname().sysname

    -- OS 名をグローバル変数に保存（必要なら）
    vim.g.os_name = uname
    print("Detected OS: " .. vim.g.os_name)

    require("base")
    require("options")
    require("keymaps")

    require("plugins.lazy")
    Bmods = require("pocket.Bmods")


    -- require("tools.settings")
    -- local experiments = require("experiments")

    -- 
    -- -- if vim.fn.filereadable(vim.fn.expand("/tmp/8ucchiman/nvim")) then
    -- if file_exists("/tmp/8ucchiman/nvim/sample.lua") then
    --     vim.opt.runtimepath:append('/tmp/8ucchiman')
    --     require("sample")
    -- end
end

local success, err = pcall(main)
if not success then
    print("Error:", err)
end
