#!/usr/bin/env lua
--
-- FileName:     sample02
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-04-23 16:11:08
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--


co = coroutine.create(function()
    for i=1, 10 do
        print("co", i)
        coroutine.yield()
    end
end)


print(co)
print(coroutine.resume(co))
print(coroutine.status(co))
print(coroutine.resume(co))
