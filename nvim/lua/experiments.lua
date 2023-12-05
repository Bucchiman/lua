#!/usr/bin/env lua
--
-- FileName:     experiments
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-04 00:47:41
-- LastModified: 2023-12-05 16:09:31
-- Reference:    https://zenn.dev/botamotch/articles/46bd760b44c6a2
--               https://zenn.dev/kawarimidoll/articles/7e986ceb6802fc
-- autocmdに関するドキュメント: https://vim-jp.org/vimdoc-ja/autocmd.html

-- vim.api.nvim_command('set runtimepath^=.')


Bmods = require("Bmods")


local Window = {}

function Window:new()
    local w = {}
    w.bufnr = vim.api.nvim_create_buf(false, true)  -- 一時バッファ作成
    return w
end


local win = Window.new()

local M = {}
--M.Window = Window

function M.nvim_open_win()
    h = vim.opt.lines['_value'] - vim.o.cmdheight
    w = vim.o.columns

    vim.api.nvim_open_win(
    win.bufnr,
    true,               -- ウィンドウに移動するか
    {
        relative="cursor",    -- editor/win/cursor/mouse
        anchor="SW",
        width=80,             -- ウィンドウの幅
        height=30,            -- ウィンドウの高さ
        col=w-80-5,           -- 右からの距離
        row=h-30-3,           -- 上からの距離
        focusable=true,
    })
end

function M.term_split()
    vim.api.nvim_command('split | wincmd j | resize 10 | terminal')
end


local api = vim.api
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local yankGrp = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

--vim.api.nvim_create_user_command('T', 'split | wincmd j | resize 10 | terminal', {nargs=0})

-- バッファの新規作成でコマンド実行
autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.c", "*.h"},
    command = "echo 'Entering a C or C++ file'",
})


-- autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = {"*.jpg"},
--     callback = function ()
--         vim.opt.guifont = string.gsub(vim.opt.guifont._value, ":h(%d+)", string.format(":h%d", 5))
--     end,
-- })
-- autocmd({"BufLeave", "BufWinLeave"}, {
--     pattern = {"*.jpg"},
--     callback = function ()
--         vim.opt.guifont = string.gsub(vim.opt.guifont._value, ":h(%d+)", string.format(":h%d", 17))
--     end,
-- })



-- 起動後に文字列を出力
--autocmd("VimEnter", {
--    command = "echo '8ucchiman was here!'",
--})


-- 起動後にコールバック軌道
--autocmd("VimEnter", {
--    callback = M.term_split
--    --command = 
--})

--autocmd("VimEnter", {
--    command = "buffer 1"
--})


--autocmd('BufWritePre', {
--    pattern = '',
--    command = ":%s/\\s\\+$//e",
--})



local mt = {
    __add = complex_add,
    __mul = complex_multiply,
}

local function complex(real, imaginary)
    local result = {
        real = real,
        imaginary = imaginary,
    }
    setmetatable(result, mt)
    return result
end

-- バッファの数
-- vim.cmd('echo len(filter(range(1, bufnr("$")), "buflisted(v:val)"))')

--vim.cmd('buffers')
--vim.cmd([[
--    let g:multiline_list = [
--        \ 1,
--        \ 2,
--        \ 3,
--        \ ]
--    echo g:multiline_list
--]])

--v = {
--    name="feifei",
--    age=28,
--    sex="female"
--}
--
--setmetatable(v, {memo1="test1", memo2="test2"})
--
--for key, val in pairs(v) do
--    print(key, val)
--end

--print(vim.api.nvim_get_current_win())
--print(vim.api.nvim_buf_get_name(1))
--print(tostring(vim.api.nvim_get_current_line()))

function file_exists(name)
   local f=io.open(name, "r")
   if f~=nil then io.close(f) return true else return false end
end

if file_exists("$HOME/common/development/schedule.nvim") then
    vim.cmd("set runtimepath+=$HOME/common/development/schedule.nvim")
    vim.cmd('source $HOME/common/development/schedule.nvim/plugin/schedule.lua')
end

vim.cmd('nnoremap <Space>v :call sml#mode_on()<CR>')

vim.keymap.set("n", "<C-s><leader>", function () Bmods.getPaste() end)

-- Reference: https://blog.atusy.net/2022/04/28/vim-colorscheme-by-buffer/
-- vim.api.nvim_create_autocmd(
--   'BufEnter',
--   {
--     pattern = '*',
--     callback = function(args)
--       local FILE = args.file  -- バッファのファイル名
--       local CWD = vim.fn.getcwd() -- 作業ディレクトリのパス
-- 
--       -- カラースキームの決定
--       -- ファイル名がCWDで始まっていればdesertを選択、それ以外はeveningを選択
--       local COLORSCHEME = CWD == string.sub(FILE, 1, string.len(CWD))
--                           and 'desert'  -- 普段用
--                           or 'evening'  -- 作業ディレクトリ外のバッファ用
-- 
--       -- カラースキームの適用
--       vim.cmd('colorscheme ' .. COLORSCHEME)
--     end
--   }
-- )

-- 
-- 第一引数の `bufnr` には、シェルを開いている :terminal のバッファ番号が入っている。
-- function! Tapi_getcwd(bufnr, ...) abort
--   -- Vim のカレントディレクトリの取得。
--   let cwd = call('getcwd', a:000)
-- 
--   -- `bufnr` で示される :terminal のバッファに紐づいているチャネルを取得。
--   let channel = term_getjob(a:bufnr)->job_getchannel()
-- 
--   -- 取得したチャネルを使って、標準入力に Vim のカレントディレクトリのパスを書き込み。
--   -- ここで書き込んだデータが `synccwd` コマンド内の `read cwd` コマンドで読み出される。
--   call ch_sendraw(channel, cwd . "\n")
-- endfunction

vim.cmd([[ autocmd DirChanged * lua vim.schedule_wrap(require('oil').open)(vim.v.event.cwd) ]])

-- Insert timestamp after 'LastModified: '
--function! LastModified()
--    if &modified
--	let save_cursor = getpos(".")
--	let n = min([40, line("$")])
--	keepjumps exe '1,' . n . 's#^\(.\{,10}LastModified: \).*#\1' . \ strftime('%Y-%m-%d %H:%M:%S %z') . '#e'
--	call histdel('search', -1)
--	call setpos('.', save_cursor)
--    endif
--endfun
--autocmd BufWritePre * call LastModified()

-- -> change
-- vim.api.nvim_create_autocmd("BufWritePre",{
--     pattern = "*",
--     callback = function ()
--         if vim.opt.modified then
--             local save_cursor = vim.fn.getpos(".")
--             -- vim.cmd('echo 123455 8ucchiman')
-- 
--             -- vim.cmd('keepjumps exe '1,' . n . 's#^\(.\{,10}LastModified: \).*#\1' . \ strftime('%Y-%m-%d %H:%M:%S %z') . '#e'')
--             vim.fn.histdel('search', -1)
--             vim.fn.setpos('.', save_cursor)
--         end
--     end
-- })

local function update_modified_date ()
    local n = math.min(vim.api.nvim_buf_line_count(0), 10)
    local lines = vim.api.nvim_buf_get_lines(0, 0, n, false)
    local pattern = '(LastModified: ).*'
    local repl

    for i, line in ipairs(lines) do
        if line:find(pattern) then
            repl = line:gsub(pattern, '%1' .. os.date('%Y-%m-%d %H:%M:%S'))
            vim.api.nvim_buf_set_lines(0, i - 1, i, false, { repl })
        end
    end
end
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function ()
        local buf = vim.api.nvim_get_current_buf()
        local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
        if buf_modified then
            update_modified_date()
        end

    end
})


vim.keymap.set("n", "<leader><leader>", function () vim.cmd("!ln -sf $HOME/.config/template/template.zsh Brun") end)

vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})
vim.api.nvim_set_hl(0, "Tips", {bg='#2F0B3A'})

return M
