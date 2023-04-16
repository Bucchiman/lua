-- Reference: https://zenn.dev/botamotch/articles/46bd760b44c6a2

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


vim.api.nvim_create_user_command('T', 'split | wincmd j | resize 10 | terminal', {nargs=0})

return M
