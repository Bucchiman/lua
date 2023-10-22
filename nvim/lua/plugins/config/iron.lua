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
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = require('iron.view').bottom(40),
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
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')




-- local view = require("iron.view")
-- 
-- -- iron.setup {...
-- 
-- -- The same size arguments are valid for float functions
-- repl_open_cmd = view.top("10%")
-- 
-- -- `view.center` takes either one or two arguments
-- repl_open_cmd = view.center("30%", 20)
-- 
-- -- If you supply only one, it will be used for both dimensions
-- -- The function takes an argument to whether the orientation is vertical(true) or
-- -- horizontal (false)
-- repl_open_cmd = view.center(function(vertical)
-- -- Useless function, but it will be called twice,
-- -- once for each dimension (width, height)
--   if vertical then
--     return 50
--   end
--   return 20
-- end)
-- 
-- -- `view.offset` allows you to control both the size of each dimension and
-- -- the distance of them from the top-left corner of the screen
-- repl_open_cmd = view.offset{
--   width = 60,
--   height = vim.o.height * 0.75,
--   w_offset = 0,
--   h_offset = "5%"
-- }
-- 
-- -- Some helper functions allow you to calculate the offset
-- -- in relation to the size of the window.
-- -- While all other sizing functions take only the orientation boolean (vertical or not),
-- -- for offsets, the functions will also take the repl size in that dimension
-- -- as argument. The helper functions then return a function that takes two arguments
-- -- to calculate the offset
-- repl_open_cmd = view.offset{
--   width = 60,
--   height = vim.o.height * 0.75,
--   -- `view.helpers.flip` will subtract the size of the REPL
--   -- window from the total dimension, then apply an offset.
--   -- Effectively, it flips the top/left to bottom/right orientation
--   w_offset = view.helpers.flip(2),
--   -- `view.helpers.proportion` allows you to apply a relative
--   -- offset considering the REPL window size.
--   -- for example, 0.5 will centralize the REPL in that dimension,
--   -- 0 will pin it to the top/left and 1 will pin it to the bottom/right.
--   h_offset = view.helpers.proportion(0.5)
-- }
-- 
-- -- Differently from `view.center`, all arguments are required
-- -- and no defaults will be applied if something is missing.
-- repl_open_cmd = view.offset{
--   width = 60,
--   height = vim.o.height * 0.75,
--   -- Since we know we're using this function in the width offset
--   -- calculation, we can ignore the argument
--   w_offset = function(_, repl_size)
--     -- Ideally this function calculates a value based on something..
--     return 42
--   end,
--   h_offset = view.helpers.flip(2)
-- }

return M
