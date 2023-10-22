#!/usr/bin/env lua
--
-- FileName:     modules
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-06 19:24:06
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- vim.api.nvim_command('set runtimepath^=.')


local M = {}
local win, buf
local position = 0


M.hello_8ucchiman = "8ucchiman was here!!"

M.open_window = function ()
    buf = vim.api.nvim_create_buf(false, true)
    local border_buf = vim.api.nvim_create_buf(false, true)   -- 空のバッファを作成

    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'schedule')

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local border_opts = {
        style = "minimal",
        relative = "editor",
        width = win_width + 2,
        height = win_height + 2,
        row = row - 1,
        col = col - 1
    }

    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
    local middle_line = '║' .. string.rep(' ', win_width) .. '║'
    for i=1, win_height do
        table.insert(border_lines, middle_line)
    end
    table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')
    vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)    -- バッファの内容を書き換える

    local border_win = vim.api.nvim_open_win(border_buf, true, border_opts)
    win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)

    vim.api.nvim_win_set_option(win, 'cursorline', true)    -- windowハンドルを指定してウィンドウオプションを指定

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { M.center('Schedule'), '', ''})
    vim.api.nvim_buf_add_highlight(buf, -1, 'ScheduleHeader', 0, 0, -1)
end


M.center = function(str)
    local width = vim.api.nvim_win_get_width(0)
    local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
    return string.rep(' ', shift) .. str
end

M.set_mappings = function ()
    local mappings = {
        ['['] = 'update_view(-1)',
        [']'] = 'update_view(1)',
        ['<cr>'] = 'open_file()',
        h = 'update_view(-1)',
        l = 'update_view(1)',
        q = 'close_window()',
        k = 'move_cursor()'
    }

    for k, v in pairs(mappings) do
        vim.api.nvim_buf_set_keymap(buf, 'n', k, v..'<cr>', {
            nowait = true, noremap = true, silent = true
        })
    end

    local other_chars = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    }
    for _, v in ipairs(other_chars) do
        vim.api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
    end
end

M.close_window = function ()
    vim.api.nvim_win_close(win, true)
end

M.open_file = function ()
    local str = vim.api.nvim_get_current_line()
    M.close_window()
    vim.api.nvim_command('edit '..str)
end

M.move_cursor = function ()
    local new_pos = math.max(4, vim.api.nvim_win_get_cursor(win)[1] - 1)
    vim.api.nvim_win_set_cursor(win, {new_pos, 0})
end

return M
