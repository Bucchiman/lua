#!/usr/bin/env lua
--
-- FileName:     floating_window_move
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-08 21:27:55
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')
vim.cmd [[colorscheme blue]]


local function move(direction, value)
    local contents_window_id = vim.api.nvim_get_current_win()
    local border_window_id = window_ids[contents_window_id] or -1
    for _, id in ipairs({contents_window_id, border_window_id}) do
        local config = vim.api.nvim_win_get_config(id)
        if direction == 'x' then
            config.col = config.col + value
        else
            config.row = config.row + value
        end
        vim.api.nvim_win_set_config(id, config)
    end
end

-- 2つで1つのウィンドウとしてみせる
local function new_window(config, field)
    local border_window_id = create_border_window(config)
    local contents_window_id = create_contents_window(config, field)
    -- コンテンツ用ウィンドウと枠線用ウィンドウを紐付ける
    window_ids[contents_window_id] = border_window_id
    -- ウィンドウ削除処理を、コンテンツ用ウィンドウに登録
    nnoremap <buffer><nowait><silent> :q<CR> :call <SID>close_window()<CR>
    -- 移動操作を登録
    nnoremap <buffer><nowait><silent> l :call <SID>move('x', 1)<CR>
    nnoremap <buffer><nowait><silent> h :call <SID>move('x', -1)<CR>
    nnoremap <buffer><nowait><silent> j :call <SID>move('y', 1)<CR>
    nnoremap <buffer><nowait><silent> k :call <SID>move('y', -1)<CR>
    return contents_window_id
end
