#!/usr/bin/env lua
--
-- FileName:     bucchiman
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-07-15 22:54:18
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


vim.api.nvim_command('set runtimepath^=.')
local current_dir = os.getenv("PWD")

local uv = vim.loop

local Bucchiman = {}
Bucchiman.new = function()
    local self = setmetatable({}, { __index = Bucchiman })
    self.images = {}
    self.default_options = {
        wait_ms = 100,
        direction = 'expand',
        count = 3,
    }
    return self
end


function Bucchiman:setup()
    vim.api.nvim_create_user_command('Bucchiman', function(options)
        local opts = options.args == '' and {} or assert(loadstring('return ' .. options.args)())
        -- self:start(opts)
        -- self:playground()
        self:load_images()
    end, { nargs = '?' })
end

function Bucchiman:playground()
    print(current_dir)
end


function Bucchiman:load_images()
    local dir = uv.fs_opendir(current_dir .. "/data/pics")
    local entry = dir:readdir()
    if entry and #entry == 1 then
        local file = entry[1]
        print(file.name)
    end
    dir:closedir()
end


local Bu = Bucchiman.new()

return {
    bucchiman = Bu,
    setup = function()
        Bu:setup()
    end,
}
