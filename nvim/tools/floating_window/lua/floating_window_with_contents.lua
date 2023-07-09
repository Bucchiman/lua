#!/usr/bin/env lua
--
-- FileName:     floating_window_with_contents
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-08 21:03:23
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')
vim.cmd [[colorscheme blue]]

-- コンテンツ用ウィンドウの作成
local function create_contents_window(config, field)
    local config = {
        relative= 'editor',
        row= config.row + 1,
        col= config.col + 2,
        width= config.width - 4,
        height= config.height - 2,
        style= 'minimal'}
    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, true, field)
    return vim.api.nvim_open_win(buffer, true, config)
end

-- 枠線用ウィンドウの作成
local function create_border_window(config)
    local width = config.width
    local height = config.height
    local top = "╭" .. string.rep("─", width - 2) .. "╮"
    local mid = "│" .. string.rep(" ", width - 2) .. "│"
    local bot = "╰" .. string.rep("─", width - 2) .. "╯"
    local lines = {}
    table.insert(lines, top)
    table.insert(lines, string.rep(mid, height-2))
    table.insert(lines, bot)
    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, true, lines)
    return vim.api.nvim_open_win(buffer, true, config)
end


-- 2つで1つのウィンドウとしてみせる
local function new_window(config, field)
    create_border_window(config)
    create_contents_window(config, field)
end

local config = {
    relative = 'editor',
    row = 30,
    col = 30,
    width = 50,
    height = 20,
    anchor = 'NW',
    style = 'minimal'
}
local field = {
    '今日の日付',
    '',
    '2021/01/31'
}

new_window(config, field)
