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


local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug", "layer" } or { "viu", "-b" }

M = {
    previewers = {
        builtin = {
            ueberzug_scaler = "cover",
            extensions = {
            ["gif"] = img_previewer,
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            },
        },
    }
}




-- https://github.com/ibhagwan/fzf-lua/issues/57
function M.git_history(opts)
    if not opts then opts = {} end
    opts.prompt = opts.prompt or "Git History> "
    opts.input_prompt = opts.input_prompt or "Search For> "

    opts.cmd = require('fzf-lua.path').git_cwd("git log --pretty --oneline --color", opts.cwd)
    opts.preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}"

    if not opts.search then
        opts.search = vim.fn.input(opts.input_prompt) or ""
    end

    opts.cmd = opts.cmd .. " -S " .. vim.fn.shellescape(opts.search)
    require("fzf-lua").git_commits(opts)
end

function M.dotstation(opts)
    require("fzf-lua").files({ cwd = "$HOME/.config/lib/codes" })
end

-- function M.snippets()
--     require("fzf-lua").files({
--         prompt = "Snippet> ",
--         cmd = "ls",
--         cwd = "$HOME/.config/snippets"
--         })
-- end
