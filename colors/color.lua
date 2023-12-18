#!/usr/bin/env lua
--
-- FileName:     color
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-16 14:44:34
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://github.com/randrews/color.git
-- Description:  ---
--


local color = {_NAME="color"}

local _M = color
local esc = string.char(27, 91)

local names = {
    'black',
    'red',
    'green',
    'yellow',
    'blue',
    'pink',
    'cyan',
    'white'
}

local hi_names = {
    'BLACK',
    'RED',
    'GREEN',
    'YELLOW',
    'BLUE',
    'PINK',
    'CYAN',
    'WHITE'
}

for key, value in pairs(hi_names) do
    print(key, value)
end

color.fg, color.bg = {}, {}

for i, name in ipairs(names) do
    color.fg[name] = esc
end
