#!/usr/bin/env lua
--
-- FileName:      tips
-- Author:        8ucchiman
-- CreatedDate:   2023-10-26 13:31:18
-- LastModified:  2023-01-25 10:56:12 +0900
-- Reference:     https://qiita.com/Qiita/items/c686397e4a0f4f11683d
-- Description:   ---
--

---------------------------------------------- 
-- io.open


----------------------------------------------
-- # vim.api.nvim_create_autocmd
--2023-11-08 16時28分56秒

--Reference: https://coralpink.github.io/commentary/neovim/au/nvim_create_autocmd.html



----------------------------------------------
-- # How Do You Save the Output of a Shell Command to a Lua Variable
-- - `vim.cmd`
--     - just runs a Ex command withour output
-- - `vim.api.nvim_exec(command, true)`
--     - give you output
-- - `vim.fn.system`


-- Reference: https://www.reddit.com/r/neovim/comments/vygdbi/how_do_you_save_the_output_of_a_shell_command_to/

----------------------------------------------
-- # vim.system({cmd}, {opts}, {on_exit})

local on_exit = function(obj)
  print(obj.code)
  print(obj.signal)
  print(obj.stdout)
  print(obj.stderr)
end

-- Run asynchronously
vim.system({'echo', 'hello'}, { text = true }, on_exit)

-- Run synchronously
local obj = vim.system({'echo', 'hello'}, { text = true }):wait()
-- { code = 0, signal = 0, stdout = 'hello', stderr = '' }

-- Reference: :help vim.system()

----------------------------------------------
-- # vim.api.nvim_open_win({buffer}, {enter}, {config})
-- - {buffer}: buffer to display, or 0 for current buffer
-- - {enter}:  enter the window (make it the current window)
-- - {config}:
-- 
-- - 2023-11-12 15時59分45秒
-- - [reference](https://neovim.io/doc/user/api.html#nvim_open_win())

----------------------------------------------
-- Reference: https://www.lua.org/pil/20.1.html
-- 2023-12-05 10:35:41

s = "hello world"
i, j = string.find(s, "hello")      -- i: the index where the match begins
                                    -- j: the index where the match ends
print(i, j)                         -- 1 5

i, j = string.find(s, "world")
print(i, j)                         -- 7 11

-- string.gsub(a subject string, a pattern, a replacement string)
s = string.gsub("Lua is cute", "cute", "great")
print(s)


----------------------------------------------
-- Reference https://www.reddit.com/r/neovim/comments/13el4fz/check_if_buffer_is_modified_and_execute_command/
local buf = vim.api.nvim_get_current_buf()
local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
print(buf_modified)

----------------------------------------------
