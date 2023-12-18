#!/usr/bin/env lua
--
-- FileName:     floating_window_final
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-08 21:32:58
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')


-- 枠線用ウィンドウとコンテンツウィンドウを紐付ける連想配列
local window_ids = {}

-- コンテンツ用ウィンドウの作成
local function create_contents_window(config, field)
    config = {
        relative = 'editor',
        row = config.row + 1,
        col = config.col + 2,
        width = config.width - 4,
        height = config.height - 2,
        style = 'minimal'
    }
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

local function move(direction, value)
    local contents_window_id = vim.api.nvim_get_current_win()
    -- local border_window_id = get(window_ids, contents_window_id, -1)
    local border_window_id = -1
    for i, val in ipairs(window_ids) do
        if contents_window_id == val then
            border_window_id = i
        end
    end

    for id in {contents_window_id, border_window_id} do
        local config = vim.api.nvim_win_get_config(id)
        if direction == 'x' then
            config.col = config.col + value
        else
            config.row = config.row + value
        end
        vim.api.nvim_win_set_config(id, config)
    end
end

-- コンテンツ・枠線のウィンドウを削除
-- コンテンツウィンドウIDを引数で指定できるようにしておくと便利
local function close_window(...)
    local contents_window_id = vim.api.nvim_get_current_win()
    -- local contents_window_id = (0 == 0) ? vim.api.nvim_get_current_win() : a:1
    local border_window_id = -1
    for i, value in ipairs(window_ids) do
        if contents_window_id == value then
            border_window_id = i
        end
    end
   if border_window_id ~= -1 then
        vim.api.nvim_win_close(contents_window_id, true)
        vim.api.nvim_win_close(border_window_id, true)
        table.remove(window_ids, contents_window_id)
    end
end

-- 2つで1つのウィンドウとしてみせる
local function new_window(config, field)
    local border_window_id = create_border_window(config)
    local contents_window_id = create_contents_window(config, field)
    -- コンテンツ用ウィンドウと枠線用ウィンドウを紐付ける
    window_ids[contents_window_id] = border_window_id
    -- ウィンドウ削除処理を、コンテンツ用ウィンドウに登録

    vim.cmd([[
    nnoremap <buffer><nowait><silent> :q<CR> :call <SID>close_window()<CR>
    ]])
    vim.cmd([[
    nnoremap <buffer><nowait><silent> j :call <SID>move('y', 1)<CR>
    ]])
    vim.cmd([[
    nnoremap <buffer><nowait><silent> k :call <SID>move('y', -1)<CR>
    ]])
    vim.cmd([[
    nnoremap <buffer><nowait><silent> l :call <SID>move('x', 1)<CR>
    ]])
    vim.cmd([[
    nnoremap <buffer><nowait><silent> h :call <SID>move('x', -1)<CR>
    ]])

    return contents_window_id
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
local field = {'今日の日付', '2023/07/09'}

local contents_window_id = new_window(config, field)
-- nnoremap T :call <SID>close_window(contents_window_id)<CR>
-- vim.api.nvim_buf_set_keymap(0, 'n', 'T', ':lua require("<SID>").close_window(contents_window_id)<CR>', {noremap = true, silent = true})
-- vim.api.nvim_buf_set_keymap(0, 'n', 'T', '<cmd>fw.close_window(contents_window_id)<CR>', {noremap = true, silent = true})
vim.cmd([[
nnoremap T :call <SID>close_window(contents_window_id)<CR>
]])
