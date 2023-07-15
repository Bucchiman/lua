#!/usr/bin/env lua
--
-- FileName:     floating_window
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-08 19:42:53
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://www.rasukarusan.com/entry/2021/01/31/132414
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')


-- コンテンツ用ウィンドウの作成
local function create_contents_window(config)
  local config = {
      relative = 'editor',
      row = config.row + 1,
      col = config.col + 2,
      width = config.width - 4,
      height = config.height - 2,
      style = 'minimal'
  }
  local buffer = vim.api.nvim_create_buf(false, true)
  return vim.api.nvim_open_win(buffer, true, config)
end

-- 枠線用ウィンドウの作成
local function create_border_window(config)
  local width = config.width
  local height = config.height
  local top = "╭" .. string.rep("─", width - 2) .. "╮"
  local mid = "│" .. string.rep(" ", width - 2) .. "│"
  local bot = "╰" .. string.rep("─", width - 2) .. "╯"
  local lines = {top}
  for i = 1, height - 2 do
    table.insert(lines, mid)
  end
  table.insert(lines, bot)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buffer, 0, -1, true, lines)
  return vim.api.nvim_open_win(buffer, true, config)
end

-- 2つで1つのウィンドウとしてみせる
local function new_window(config)
  create_border_window(config)
  create_contents_window(config)
end

-- ex.) 使い方
local config = {
    relative = 'editor',
    row = 30,
    col = 30,
    width = 50,
    height = 20,
    anchor = 'NW',
    style = 'minimal'
}
new_window(config)


