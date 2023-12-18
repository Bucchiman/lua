--buf = vim.api.nvim_create_buf(false, true)

-- https://neovim.io/doc/user/api.html#nvim_buf_get_lines()
-- 現在のバッファのテキストを取得
-- nvim_buf_get_lines({buffer}, {start}, {end}, {strict_indexing})
-- 引数: buffer          : バッファ指定, 0の場合カレントバッファ
--       start           : 開始位置
--       end             : 終点位置(-1の場合最後まで)
--       strict_indexing : bool
local t = vim.api.nvim_buf_get_lines(0, 2, -1, true)


for num, line in ipairs(t) do
    print(num, line)
end



local current_cursor = vim.api.nvim_win_get_cursor(0)
print(type(current_cursor))

--print(current_cursor)
for num, cursor in ipairs(current_cursor) do
    print(num, cursor)
end
