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
