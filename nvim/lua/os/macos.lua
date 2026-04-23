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

    if vim.g.neovide then
        vim.g.neovide_opacity = 1.0
        vim.g.neovide_normal_opacity = 1.0
        vim.g.neovide_window_blurred = false
        -- Disable transparent.nvim (applied in base.lua before this file)
        vim.g.transparent_enabled = false
        -- Override semi-transparent background set in local.lua (alpha cc → ff)
        vim.g.neovide_background_color = "#0f1117ff"
        -- Re-apply colorscheme to restore highlight groups cleared by transparent.nvim
        if vim.g.colors_name then
            vim.cmd("colorscheme " .. vim.g.colors_name)
        end
    end
end

M:init()



