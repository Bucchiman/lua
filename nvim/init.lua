#!/usr/bin/env lua
--
-- FileName:     init
-- Author:       8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2023-12-12 00:35:47
-- Reference:    https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--               https://developer.jmatsuzaki.com/posts/get-file-name-in-vim/
--


local home_dir = os.getenv('HOME')
if home_dir == nil then
    home_dir = os.getenv('UserProfile')
end
local current_dir = vim.fn.getcwd()
local nvim_qt_dir = os.getenv('NVIM_QT_RUNTIME_PATH')

require("base")
require("options")
require("keymaps")

function file_exists(name)
   local f=io.open(name, "r")
   if f~=nil then io.close(f) return true else return false end
end
-- 
-- if vim.fn.filereadable("$HOME/.config/local/lua/local.lua") then
if file_exists(home_dir .. "/.config/local/lua/local.lua") then
    vim.opt.runtimepath:append('$HOME/.config/local')
    require("local")
end
-- 
-- -- if vim.fn.filereadable(vim.fn.expand("/tmp/8ucchiman/nvim")) then
-- if file_exists("/tmp/8ucchiman/nvim/sample.lua") then
--     vim.opt.runtimepath:append('/tmp/8ucchiman')
--     require("sample")
-- end

-- require("plugins.lazy")
-- require("tools.settings")
-- local experiments = require("experiments")


