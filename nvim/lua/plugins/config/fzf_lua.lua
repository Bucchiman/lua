#!/usr/bin/env lua
--
-- FileName:     fzf_lua
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-06 23:57:24
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- vim.api.nvim_command('set runtimepath^=.')

-- local opts = { noremap = true, silent = true }
-- 
-- 
-- local keymap = vim.api.nvim_set_keymap
-- 
-- 

local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug", "layer" } or { "viu", "-b" }

M = {
    previewers = {
        builtin = {
            ueberzug_scaler = "cover",
            extensions = {
            ["gif"] = img_previewer,
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            },
        },
    }
}




-- https://github.com/ibhagwan/fzf-lua/issues/57
function M.git_history(opts)
    if not opts then opts = {} end
    opts.prompt = opts.prompt or "Git History> "
    opts.input_prompt = opts.input_prompt or "Search For> "

    opts.cmd = require('fzf-lua.path').git_cwd("git log --pretty --oneline --color", opts.cwd)
    opts.preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}"

    if not opts.search then
        opts.search = vim.fn.input(opts.input_prompt) or ""
    end

    opts.cmd = opts.cmd .. " -S " .. vim.fn.shellescape(opts.search)
    require("fzf-lua").git_commits(opts)
end

function M.codestation(opts)
    require("fzf-lua").files({
        prompt = "Code> ",
        cmd = "ls",
        cwd = "$HOME/.config/lib/codes"
        })

end

function M.snippets()
    require("fzf-lua").files({
        prompt = "Snippet> ",
        cmd = "ls",
        cwd = "$HOME/.config/snippets"
        })
end

---
-- Function to retrieve console output
-- 
function os.capture(cmd, raw)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))
    
    handle:close()
    
    if raw then 
        return output 
    end
   
    output = string.gsub(
        string.gsub(
            string.gsub(output, '^%s+', ''), 
            '%s+$', 
            ''
        ), 
        '[\n\r]+',
        ' '
    )
   
   return output
end

function M.onelines()
    -- print(os.capture('$(/usr/bin/find $HOME/.config/lib/onelines -type f | fzf --height 100% --preview "bat --color=always {}")'))
    print(os.capture('/usr/bin/find $HOME/.config/lib/onelines -type f | fzf'))
end

function M.readme()
    require("fzf-lua").files({
        prompt = "README> ",
        cmd = "ls",
        cwd = "$HOME/.config/lib/readme"
        })

end



return M
