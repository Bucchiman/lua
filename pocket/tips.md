<!--
 FileName:      tips
 Author:        8ucchiman
 CreatedDate:   2023-10-26 13:31:18
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     https://qiita.com/Qiita/items/c686397e4a0f4f11683d
 Description:   ---
-->

<!-- ---------------------------------------------- -->
io.open


<!-- ---------------------------------------------- -->
# vim.api.nvim_create_autocmd
2023-11-08 16時28分56秒

Reference: https://coralpink.github.io/commentary/neovim/au/nvim_create_autocmd.html



<!-- ---------------------------------------------- -->
# How Do You Save the Output of a Shell Command to a Lua Variable
- `vim.cmd`
    - just runs a Ex command withour output
- `vim.api.nvim_exec(command, true)`
    - give you output
- `vim.fn.system`


Reference: https://www.reddit.com/r/neovim/comments/vygdbi/how_do_you_save_the_output_of_a_shell_command_to/

<!-- ---------------------------------------------- -->
# vim.system({cmd}, {opts}, {on_exit})

```lua
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
```

Reference: :help vim.system()

<!-- ---------------------------------------------- -->
# vim.api.nvim_open_win({buffer}, {enter}, {config})
- {buffer}: buffer to display, or 0 for current buffer
- {enter}:  enter the window (make it the current window)
- {config}:

- 2023-11-12 15時59分45秒
- [reference](https://neovim.io/doc/user/api.html#nvim_open_win())
