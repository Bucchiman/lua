-- Runs after ALL plugins (iceberg, coc.nvim, etc.) have loaded.
-- In Neovide, transparent.nvim is disabled (cond=false), so nothing re-fires on FileType/CocNvimInit.
-- This file replaces that role: re-applies float highlights unconditionally.

local function fix_float_hl()
    vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "#1e2132", fg = "#c6c8d1" })
    vim.api.nvim_set_hl(0, "FloatBorder",  { bg = "#1e2132", fg = "#6e7597" })
    vim.api.nvim_set_hl(0, "Pmenu",        { bg = "#1e2132", fg = "#c6c8d1" })
    vim.api.nvim_set_hl(0, "PmenuSel",     { bg = "#2d3149", fg = "#eff0f4" })
    vim.api.nvim_set_hl(0, "PmenuSbar",    { bg = "#1e2132" })
    vim.api.nvim_set_hl(0, "PmenuThumb",   { bg = "#6e7597" })
    vim.api.nvim_set_hl(0, "WildMenu",     { bg = "#2d3149", fg = "#eff0f4" })
    vim.api.nvim_set_hl(0, "CocFloating",  { bg = "#1e2132", fg = "#c6c8d1" })
    vim.api.nvim_set_hl(0, "CocMenuSel",   { bg = "#2d3149", fg = "#eff0f4" })
end

-- Immediate: runs after all plugins (including iceberg + coc's ColorScheme handler)
fix_float_hl()

-- Cover deferred highlight resets from plugins
vim.defer_fn(fix_float_hl, 200)
vim.defer_fn(fix_float_hl, 600)
vim.defer_fn(fix_float_hl, 1100)
vim.defer_fn(fix_float_hl, 3100)
vim.defer_fn(fix_float_hl, 5100)

-- Re-apply on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_float_hl })

-- Re-apply when coc.nvim's async server finishes init (may reset CocFloating)
vim.api.nvim_create_autocmd("User", {
    pattern = "CocNvimInit",
    callback = function()
        fix_float_hl()
        vim.defer_fn(fix_float_hl, 200)
    end,
})

-- Re-apply on every FileType event (mirrors what transparent.nvim does in non-Neovide)
-- This catches any plugin that resets highlights after opening a buffer
vim.api.nvim_create_autocmd("FileType", { callback = fix_float_hl })

-- Force winblend=0 on every floating window as it opens
vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
        vim.schedule(function()
            local ok, win = pcall(vim.api.nvim_get_current_win)
            if not ok then return end
            local ok2, cfg = pcall(vim.api.nvim_win_get_config, win)
            if ok2 and cfg.relative ~= "" then
                pcall(vim.api.nvim_win_set_option, win, "winblend", 0)
            end
        end)
    end,
})
