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

-- local opts = { noremap = true, silent = true }
-- 
-- 
-- local keymap = vim.api.nvim_set_keymap
-- 
-- 
-- keymap('n', '<leader>e', "<cmd>lua require('fzf-lua').files()<CR>", opts)
-- keymap('n', '<leader>g', "<cmd>lua require('fzf-lua').git_status()<CR>", opts)
-- keymap('n', '<leader>b', "<cmd>lua require('fzf-lua').git_branches()<CR>", opts)
-- keymap('n', '<leader>p', "<cmd>lua require('fzf-lua').grep()<CR>", opts)
-- keymap('n', '<leader>/', "<cmd>lua require('fzf-lua').blines()<CR>", opts)
-- 
-- keymap('n', '<leader>r', "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
-- keymap('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
-- keymap('n', '<leader>D', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
-- keymap('n', '<leader>i', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
-- keymap('n', '<leader>s', "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
-- keymap('n', '<leader>t', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
-- keymap('n', '<leader>l', "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", opts)
