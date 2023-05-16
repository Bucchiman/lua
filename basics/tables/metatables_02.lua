#!/usr/bin/env lua
--
-- FileName:     metatables_02
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-16 14:53:08
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/6048118/how-does-the-call-metamethod-in-lua-5-1-actually-work
-- Description:  ---


local function func01(_, ...)
    print("Hello world", ...)
end


local function main()
    local M = {}
    setmetatable(M, {__call=func01})
    M()
    M("8ucchiman")
end



main()

