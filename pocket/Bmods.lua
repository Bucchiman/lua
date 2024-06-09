#!/usr/bin/env lua
--
-- FileName:     modules
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-06 19:24:06
-- LastModified: 2024-06-09 15:27:18
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- vim.api.nvim_command('set runtimepath^=.')



local M = {}
local win, buf
local position = 0


M.hello_8ucchiman = "8ucchiman was here!!"

--- debug message
-- this is specified function
-- @param
-- @return
-- @ReferenceA
M.__debug = function ()
    print("Hello world from 8ucchiman")
end


--- open window
-- @param       position
-- @return      open floating window
-- @Reference   https://github.com/rafcamlet/nvim-whid/tree/master
M.open_window = function (position)
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

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { center('Schedule'), '', ''})
    vim.api.nvim_buf_add_highlight(buf, -1, 'ScheduleHeader', 0, 0, -1)
end


function center(str)
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


--- open_file explodes text.
-- It is a specialized splitting operation on a string.
-- @param
-- @return a table of substrings
-- @example M.open_file()
M.open_file = function ()
    local str = vim.api.nvim_get_current_line()
    M.close_window()
    vim.api.nvim_command('edit '..str)
end


M.move_cursor = function ()
    local new_pos = math.max(4, vim.api.nvim_win_get_cursor(win)[1] - 1)
    vim.api.nvim_win_set_cursor(win, {new_pos, 0})
end


--- GetFileName
-- get file name from path
-- @param       path
-- @return      file name without extension
-- @Reference   https://codereview.stackexchange.com/questions/90177/get-file-name-with-extension-and-get-only-extension
M.GetFileName = function (url)
    return url:match("^.+/(.+)$")
end

--- GetFileExtension
-- get extension of file from path
-- @param       path
-- @return      extension of file name without extension (with .)
-- @Reference   https://codereview.stackexchange.com/questions/90177/get-file-name-with-extension-and-get-only-extension
M.GetFileExtension = function (url)
    local text = url:match("^.+(%..+)$")
    vim.notify(url)
    -- vim.notify("text in getfileextension is "..text)
    return string.sub(text, 2, -1)
end

M.StringDel = function (str, pattern)
    return string.gsub(str, pattern, "")
end



--- getPaste explodes text.
-- It is a specialized splitting operation on a string.
-- @param text the string
-- @return a table of substrings
-- @Reference   https://www.reddit.com/r/neovim/comments/vu9atg/how_do_i_get_the_text_selected_in_visual_mode/
M.getPaste = function ()
    local vstart = vim.fn.getpos("'<")

    local vend = vim.fn.getpos("'>")

    local line_start = vstart[2]
    local line_end = vend[2]

    -- or use api.nvim_buf_get_lines
    local lines = vim.fn.getline(line_start,line_end)
end


--- getPaste explodes text.
-- It is a specialized splitting operation on a string.
-- @param text the string
-- @return a table of substrings
-- @Reference   https://qiita.com/slin/items/874dbc3ca34ea83e90b7
--              https://zenn.dev/kawarimidoll/articles/0f3fdfcd881f5c
M._floating_window = function ()
    local buf = vim.api.nvim_create_buf(false, false)
    -- $1 buflisted: offの時':bnext'や':ls'の対象にならない
    -- $2 scratch:      create a scratch buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, {"test", "text"})
    -- $1 buffer
    -- $2,$3 start, end:    書き換える行数の始まりと終わり -1は末尾の下
    -- $4 strict_indexing   onの場合行数指定がバッファの範囲外の時エラーになる
    -- $5 バッファに書き込みたいテキストの配列

    local opts = {
        -- relative = 'win',
        -- win = 0,
        relative = 'cursor',
        width = 10,
        height = 2,
        col = 0,
        row = 1,
        anchor = 'NW',
        style = 'minimal'
        }
    vim.api.nvim_open_win(buf, false, opts)
    -- $1 buffer
    -- $2 enter     オンの場合、開いたウィンドウにフォーカス
    -- $3 config    table
    --      {
    --          relative = ['editor' | 'win' | 'cursor']    -- 表示場所
    --          win =                                       -- relativeにwinを指定した場合のウィンドウIDを指定
    --          anchor = ['NW' | 'NE' | 'SW' | 'SE']        -- ウィンドウの原点をどこにするか決定
    --          height = 
    --          width
    --          row
    --          col
    --          focusable
    --          external
    --          style
    --      }
    vim.api.nvim_win_close(0, false)
    -- $1 window
    -- $2 force :close!
end


-- --- 
-- -- It is a specialized splitting operation on a string.
-- -- @param text the string
-- -- @return a table of substrings
-- -- @Reference   https://vi.stackexchange.com/questions/8208/way-to-get-content-of-visual-selection
-- function pos2byte(pos)
--     return vim.fn.line2byte(pos[1]) + pos[2]
-- end
-- 
-- function get_visual_text()
--     local b1 = pos2byte(vim.fn.getpos("'<"))
--     local b2 = pos2byte(vim.fn.getpos("'>"))
--     local text = ''
-- 
--     while b1 < b2 do
--         local l = vim.fn.byte2line(b1)
--         local lb = vim.fn.line2byte(l)
--         local line = vim.fn.strpart(vim.fn.getline(l), b1-lb-1)
--         local text = text .. line
--         local b1 = b1 + vim.fn.len(line)
--     end
--     return vim.fn.strpart(text, 0, vim.fn.len(text)-(b1-b2)+1)
-- end


-- @Reference   https://www.reddit.com/r/neovim/comments/oo97pq/how_to_get_the_visual_selection_range/
local function get_visual_selection()
    -- Yank current visual selection into the 'v' register
    --
    -- Note that this makes no effort to preserve this register
    vim.cmd('noau normal! "vy"')

    return vim.fn.getreg('v')
end

-- floating window そのものの色
-- hi! NormalFloat     ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
-- vim.highlight.create("NormalFloat", {ctermbg=249, guibg=#2F0B3A, ctermfg=46, guifg=#D8D8D8}, false)
vim.api.nvim_set_hl(0, "NormalFloat", {ctermbg=0, ctermfg=46})
-- floating window の border の色指定
-- hi! FloatBorder     ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
-- vim.highlight.create("FloatBorder", {ctermbg=249, ctermfg=46, guibg=#2F0B3A, guifg=#D8D8D8}, false)
vim.api.nvim_set_hl(0, "FloatBorder", {ctermbg=249, ctermfg=46})



--- append tips
-- 
-- @param
-- @return
-- @Reference   
M.append_tips = function ()
    local extension2path = {
        zsh = "shell",
        sh = "shell",
        lua = "lua",
        c = "c",
        cpp = "c++",
        cs = "csharp",
        rs = "rust",
        py = "python",
        s = "assembler"
    }
    local file_path = vim.api.nvim_buf_get_name(0)        -- get current buffer
    local extension_name = M.GetFileExtension(file_path)
    -- print(file_path)
    local pocket_path = vim.fn.expand("$HOME/.config/pockets/")
    local tips_path = pocket_path .. extension2path[extension_name] .. "/tips." .. extension_name
    print(tips_path)
    -- local text=get_visual_selection()

    local buf = M.set_buffer(tips_path)


    -- vim.api.nvim_buf_set_lines(buf, 0, -1, true, {})

    local opts = {
        -- relative = 'win',
        -- win = 0,
        relative = 'cursor',
        width = 100,
        height = 7,
        col = 1,
        row = 2,
        anchor = 'NW',
        style = 'minimal'
    }
    local winopts = {
        style = "minimal",
        relative = "cursor",
        width = 102,
        height = 9,
        row = 1,
        col = 0,
    }
    win = vim.api.nvim_open_win(buf, true, winopts)
    vim.highlight.create('TipsColor', {guibg='#8fbcbb'}, false)
    vim.api.nvim_win_set_option(win, "TipsColor", "TipsColor")

    -- vim.api.nvim_open_win(buf, true, opts)
    -- vim.api.nvim_win_set_option(win, 'cursorline', true)    -- windowハンドルを指定してウィンドウオプションを指定
    -- vim.api.nvim_win_close(0, false)

    -- local color = "#e27878"
    -- local hl_name = "ClipBG" .. win

    -- vim.cmd("hi " .. hl_name .. 'guifg=#fffffff guibg=#fff2525')                      -- https://github.com/daverivera/neovim-dots/blob/main/init.lua 
    -- vim.highlight.create(hl_name, {ctermbg=249, guibg=#2F0B3A, ctermfg=46, guifg=#2F0B3A}, false)
    -- vim.api.nvim_set_hl(win, hl_name, { ctermfg=White,  ctermbg=Black })        -- https://stackoverflow.com/questions/71152802/how-to-override-color-scheme-in-neovim-lua-config-file

    -- vim.api.nvim_set_hl(0, "TipColor", {ctermbg=0, bg=})
    -- vim.api.nvim_win_set_option(win, "TelescopeNormal", 'TelescopeNormal')
end

vim.keymap.set("n", "<C-s><C-;>", function ()
    -- local file_path=vim.api.nvim_buf_get_name(0)        -- get current buffer
    -- local text=get_visual_selection()
    -- print(file_path)
    M.append_tips()
end)

--- READ file
-- 
-- @param text the string
-- @return a table of substrings
-- @example   Bmods.READ("/tmp/8ucchiman/memo.txt")
-- @Reference https://www.family-historian.co.uk/help/fh7-plugins/lua/readingandwritingfiles.html
M.READ = function (path)
    file = io.open(path, "r")
    for line in file:lines() do
        print(line)
    end
    file:close()
end

--- OVERWRITE file
-- 
-- @param path: a file path
--        text: strings to write in a file
-- @return      nil
-- @Reference   https://www.family-historian.co.uk/help/fh7-plugins/lua/readingandwritingfiles.html 
M.OVERWRITE = function (path, text)
    file = io.open(path, "w")
    file:write(text)
    file:close()
end

--- WRITE file
-- 
-- @param path: a file path
--        text: strings to write in a file
-- @return      nil
-- @example     Bmods.WRITE("/tmp/8ucchiman/memo.txt", "8ucchiman was here!")
-- @Reference   https://www.family-historian.co.uk/help/fh7-plugins/lua/readingandwritingfiles.html 
M.WRITE = function (path, text)
    text = text .. "\n"
    file = io.open(path, "a")
    file:write(text)
    file:close()
end

--- set_buffer
-- 
-- @param       path
-- @return      buffer
-- @Reference   https://www.reddit.com/r/neovim/comments/10idl7u/how_to_load_a_file_into_neovims_buffer_without/
M.set_buffer = function (path)
    -- local bufnr = vim.api.nvim_create_buf(true, false)
    -- vim.api.nvim_buf_set_name(bufnr, path)
    -- return bufnr
    -- -- vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
    local bufnr = vim.fn.bufadd(path)
    vim.fn.bufloaded(bufnr)
    return bufnr
end

-- M.floating_window()

-- M.open_window()



--- show oneline snippets
-- 
-- @param
-- @return
-- @Reference   
M.show_oneline = function ()
    local extension2path = {
        zsh = "shell",
        sh = "shell",
        lua = "lua",
        c = "c",
        cpp = "c++",
        cs = "csharp",
        rs = "rust",
        py = "python",
        s = "assembler",
        ps1 = "powershell"
    }
    local file_path = vim.api.nvim_buf_get_name(0)        -- get current buffer
    local extension_name = M.GetFileExtension(file_path)
    -- print(file_path)
    local pocket_path = vim.fn.expand("$HOME/.config/pockets/")
    local oneline_path = pocket_path .. extension2path[extension_name] .. "/onelines"

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    local fzf = require("fzf")

    local result
    coroutine.wrap(function()
        result = fzf.fzf("/bin/ls -1 " .. oneline_path)
        -- f = io.open(oneline_path, "r")
        -- for m in f:lines() do
        --     vim.api.nvim_put(m, 'l', false, true)
        -- end
        -- print(result[1])
        -- local text_to_print = string.format('%s', result[1])
        vim.api.nvim_put(result, 'l', false, true)

    end)()

    -- local text_to_print = string.format('%s%s', vim.api.nvim_buf_get_lines(0, row-1, col, false)[1], result[1])
    -- vim.api.nvim_put({text_to_print}, 'l', false, true)
    -- vim.api.nvim_exec(command, false)
end

vim.keymap.set("n", "<C-s><C-;>", function ()
    -- local file_path=vim.api.nvim_buf_get_name(0)        -- get current buffer
    -- local text=get_visual_selection()
    -- print(file_path)
    M.append_tips()
end)

vim.keymap.set("n", "<C-s><C-o>", function ()
    M.show_oneline()
end)


-- Function to get the absolute file path under the cursor, remove the 'oil://' prefix, and open it with viu
function OpenImageUnderCursor()
  -- Get the file path under the cursor
  local file = vim.fn.expand('<cfile>')

  -- Get the directory of the current buffer
  local dir = vim.fn.expand('%:p:h')

  -- Combine the directory and file path to get the absolute path
  local fullpath = dir .. '/' .. file

  -- Remove the 'oil://' prefix if present
  if fullpath:sub(1, 6) == 'oil://' then
    fullpath = fullpath:sub(7)
  end

  -- Check if the file exists
  if file ~= '' and vim.fn.filereadable(fullpath) == 1 then
    -- vim.cmd('silent !viu ' .. vim.fn.shellescape(fullpath))
    vim.cmd('silent !open ' .. vim.fn.shellescape(fullpath))
  else
    print(fullpath .. " is not valid file under cursor")
  end
end

-- Map <leader>i to call the function
vim.api.nvim_set_keymap('n', '<leader>i', ':lua OpenImageUnderCursor()<CR>', { noremap = true, silent = true })


-- Global variable to store the source file path
_G.source_file_path = nil

-- Define the function to handle the logic
function handle_symlink()
  -- Get the file path under the cursor
  local file = vim.fn.expand('<cfile>')

  -- Get the directory of the current buffer
  local dir = vim.fn.expand('%:p:h')

  -- Combine the directory and file path to get the absolute path
  fullpath = dir .. '/' .. file

  -- Remove the 'oil://' prefix if present
  if fullpath:sub(1, 6) == 'oil://' then
    fullpath = fullpath:sub(7)
  end

  if _G.source_file_path == nil then
    -- If the source file path is not set, store the current file path
    _G.source_file_path = fullpath
    print("Source file path set to: " .. _G.source_file_path)
  else
    -- If the source file path is already set, create the symbolic link
    local symlink_path = fullpath
    local cmd = string.format("ln -s %s %s", _G.source_file_path, symlink_path)
    os.execute(cmd)
    print(string.format("Created symlink: %s -> %s", symlink_path, _G.source_file_path))

    -- Reset the source file path for future use
    _G.source_file_path = nil
  end
end

-- Map the function to the desired keybinding
vim.api.nvim_set_keymap('n', '<Space>l', ':lua handle_symlink()<CR>', { noremap = true, silent = true })

return M
