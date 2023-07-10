#!/usr/bin/env lua
--
-- FileName:     dapui
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-05 11:12:58
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')

require("dapui").setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches", size = 0.20 },
        { id = "stacks", size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes", size = 0.40 },
      },
      size = 64,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})
