#!/usr/bin/env lua
--
-- FileName:     python
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-18 13:55:45
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')

local M = {}

function M.setup(_)
  require("dap-python").setup("python", {})
end

return M

