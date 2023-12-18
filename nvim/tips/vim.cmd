Description>
           >
           > vim.cmd('echo 42')
           > vim.cmd([[
           >   augroup My_group
           >     autocmd!
           >     autocmd FileType c setlocal cindent
           >   augroup END
           > ]])
           > -- Ex command :echo "foo"
           > -- Note string literals need to be double quoted.
           > vim.cmd('echo "foo"')
           > vim.cmd { cmd = 'echo', args = { '"foo"' } }
           > vim.cmd.echo({ args = { '"foo"' } })
           > vim.cmd.echo('"foo"')
           > -- Ex command :write! myfile.txt
           > vim.cmd('write! myfile.txt')
           > vim.cmd { cmd = 'write', args = { "myfile.txt" }, bang = true }
           > vim.cmd.write { args = { "myfile.txt" }, bang = true }
           > vim.cmd.write { "myfile.txt", bang = true }
           > -- Ex command :colorscheme blue
           > vim.cmd('colorscheme blue')
           > vim.cmd.colorscheme('blue')


Reference> https://neovim.io/doc/user/lua.html#vim.cmd()
