#!/usr/bin/env lua
--
-- FileName:     unko
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-17
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
-- Description:  ---
--


local class = require "30log"
Window = class {width = 100, height = 100, x = 10, y = 10}

appFrame = Window()
print(appFrame.x, appFrame.y)
print(appFrame.width, appFrame.height)
