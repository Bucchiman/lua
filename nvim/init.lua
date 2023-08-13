#!/usr/bin/env lua
--
-- FileName:     init
-- Author:       8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2023-03-31 21:41:28 +0900
-- Reference:    https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--               https://developer.jmatsuzaki.com/posts/get-file-name-in-vim/
--


--vim.api.nvim_command('set runtimepath^=/home/bucchiman/.config/snippets/codes/lua/nvim')
local home_dir = os.getenv('HOME')
local current_dir = vim.fn.getcwd()
--vim.api.nvim_command('set runtimepath^='..current_dir)
--vim.api.nvim_command('set runtimepath^=/home/8ucchiman/common/snippets/codes/lua/nvim/lua')
--local cfg_dir = home_dir..'/.config/snippets/codes/lua/nvim'
--print(cfg_dir)
--vim.api.nvim_command('set runtimepath^='..cfg_dir)
--print(vim.inspect(vim.api.nvim_list_runtime_paths()))


require("base")
require("options")
require("keymaps")
require("plugins.lazy")
require("tools.settings")
local experiments = require("experiments")

-- if vim.fn.filereadable(vim.fn.expand("$HOME/.config/local/init.lua")) then
--     -- print("file exists")
--     local local_config = require(vim.fn.expand("local.init"))
-- end


-- Insert timestamp after 'LastModified: '
--function! LastModified()
--    if &modified
--	let save_cursor = getpos(".")
--	let n = min([40, line("$")])
--	keepjumps exe '1,' . n . 's#^\(.\{,10}LastModified: \).*#\1' .
--		    \ strftime('%Y-%m-%d %H:%M:%S %z') . '#e'
--	call histdel('search', -1)
--	call setpos('.', save_cursor)
--    endif
--endfun
--autocmd BufWritePre * call LastModified()

-- vim.api.nvim_create_autocmd("BufWritePre",{
--     pattern = "*",
--     callback = function ()
-- 
--     end
-- })
