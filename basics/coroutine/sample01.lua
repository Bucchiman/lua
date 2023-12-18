#!/usr/bin/env lua
--
-- FileName:     sample01
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-04-23 16:07:50
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://www.lua.org/pil/9.1.html
-- Description:  ---
--


co = coroutine.create(function()
    print("hi")
end)

print(co)
print(coroutine.status(co))
print(coroutine.resume(co))
print(coroutine.status(co))
