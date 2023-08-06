#!/usr/bin/env lua
--
-- FileName:     fzf
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-06 23:57:24
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- vim.api.nvim_command('set runtimepath^=.')

local opts = { noremap = true, silent = true }


local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>ff", ":lua require('fzf-lua').files()<CR>", opts)
keymap("n", "<Leader>fb", ":lua require('fzf-lua').buffers()<CR>", opts)
keymap("n", "<Leader>fc", ":lua require('fzf-lua').colorschemes({ winopts = { height=0.33, width=0.33 } })<CR>", opts)
keymap("n", "<Leader>fg", ":lua require'fzf-lua'.live_grep({ cmd = 'git grep --line-number --column --color=always' })<CR>", opts)
