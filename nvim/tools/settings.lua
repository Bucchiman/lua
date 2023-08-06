#!/usr/bin/env lua
--
-- FileName:     settings
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-06 19:40:03
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- vim.api.nvim_command('set runtimepath^=.')

local modules = require("tools.modules")

vim.api.nvim_create_user_command("Open_Window", modules.open_window, {})
vim.api.nvim_set_keymap("n", "<Leader>8t", ":Open_Window", {noremap=true, silent=true})

-- modules.open_window()
