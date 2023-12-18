#!/usr/bin/env lua
--
-- FileName:     sample02
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-22 23:49:06
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--



function counter(i)
    local x = 0
    return function()
        x = x + 1
        if x > 1 then return null end
        return x
    end
end


sum=0
for i in counter(5) do
    for j in counter(5) do
        sum = sum + j
    end
end
