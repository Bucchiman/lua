#!/usr/bin/env lua
--
-- FileName:     sample01
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-04-23 15:59:10
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://www.lua.org/pil/6.1.html
-- Description:  クロージャに関するサンプルコード
--


names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}

for k, v in pairs(grades) do
    print(k, v)
end



function sortbygrade (names, grades)
  table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2]    -- compare the grades
  end)
end



for k, v in pairs(grades) do
    print(k, v)
end


