#!/usr/bin/env lua
--
-- FileName:     metatables
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-04 19:11:18
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://www.tutorialspoint.com/the-index-metamethod-in-lua-programming
-- Description:  ---
--


Set = {}

function Set.new (t)
  local set = {}
  for _, l in ipairs(t) do set[l] = true end
  return set
end

function Set.union (a,b)
  local res = Set.new{}
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.intersection (a,b)
  local res = Set.new{}
  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

