#!/usr/bin/env lua
--
-- FileName:     main
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-04-23 15:12:09
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://www.lua.org/pil/13.4.1.html
-- Description:  オブジェクト指向型な書き方
--


-- create a namespace
Window = {}

-- create the prototype with default values
-- self
Window.prototype = {
    x=0,
    y=0,
    width=100,
    height=100,
}
-- create a metatable
Window.mt = {}
--declare the constructor function
function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end

Window.mt.__index = function (table, key)
    return Window.prototype[key]
end

w = Window.new{x=10, y=20}
print(w.width)
print(w.x)

