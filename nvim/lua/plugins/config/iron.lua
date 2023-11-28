#!/usr/bin/env lua
--
-- FileName:     iron
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-27 13:26:39
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--



local iron = require("iron.core")
local view = require("iron.view")

M = {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = {"zsh"}
            },
            python = require("iron.fts.python").ipython
    },
        -- repl_open_cmd = view.right(30)
    -- repl_open_cmd = view.offset {
    --         width = 60,
    --         height = 20,
    --         w_offset = 50,
    --         h_offset = "10%"
    --     }
    repl_open_cmd = view.offset{
        width = 60,
        height = 20,
        w_offset = view.helpers.flip(1),
        h_offset = view.helpers.proportion(0.9)
    }
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<C-s><C-r>d",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },

  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
        bold = true,
        fg = "#FF9999"
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines

}


-- -- iron also has a list of commands, see :h iron-commands for all available commands
-- moves to which-key.lua
-- vim.keymap.set('n', '<C-r><C-r>', '<cmd>IronRepl<cr>')
-- vim.keymap.set('n', '<C-r>r', '<cmd>IronRestart<cr>')
-- vim.keymap.set('n', '<C-r>rf', '<cmd>IronFocus<cr>')
-- vim.keymap.set('n', '<C-r>rh', '<cmd>IronHide<cr>')


return M
