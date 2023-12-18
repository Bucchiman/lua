-- local api = vim.api
-- local M = {}
-- function M.makeScratch()
--   api.nvim_command("enew")
--   vim.bo[0].buftype=nofile
--   vim.bo[0].bufhidden=hide
--   vim.bo[0].swapfile=false
-- end
-- return M

vim.api.nvim_create_user_command('ExampleOpenWin', experiments.nvim_open_win, {nargs=0})
vim.api.nvim_create_user_command('T', experiments.term_split, {nargs=0})
local M = {}

M.file_exists = function (name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

return M
