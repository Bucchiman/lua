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
--require("plugins.packer")
require("plugins.lazy")
require("plugins.lspconfig")
require("plugins.dap")
--require("8ucchiman")
local experiments = require("experiments")

vim.api.nvim_create_user_command('ExampleOpenWin', experiments.nvim_open_win, {nargs=0})

vim.api.nvim_create_user_command('T', experiments.term_split, {nargs=0})

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

local file = vim.fn.expand("%")

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = {
            "*.c",
            "*.h",
            "*.hpp",
            "*.cu",
            "*.cs",
            "*.cpp",
            "*.rs",
            "*.rb",
            "*.py",
            "*.lua",
            "*.vim",
            "*.yaml",
            "*.md",
            "*.sh",
            "*.zsh",
            "*.Dockerfile",
    },
        command = "Template "..file.." template"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "CMakeLists.txt",
        command = "Template "..file.." CMakeLists"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Dockerfile",
        command = "Template "..file.." Dockerfile"
    }
)


vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Docker-compose.yml",
        command = "Template "..file.." Docker-compose"
    }
)

vim.api.nvim_create_autocmd(
    "BufNewFile",
    {
        pattern = "Makefile",
        command = "Template "..file.." Makefile"
    }
)
