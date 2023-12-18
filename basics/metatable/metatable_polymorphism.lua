#!/usr/bin/env lua
--
-- FileName:     metatable_polymorphism
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-24 22:36:51
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--



-- 2 次元座標
Point = {}

function Point.new(x, y)
  local obj = {x = x, y = y}
  return setmetatable(obj, {__index = Point})
end

-- 距離を求める
function Point.distance(p1, p2)
  local dx = p1.x - p2.x
  local dy = p1.y - p2.y
  return math.sqrt(dx * dx + dy * dy)
end

-- 3 次元座標
Point3D = {}

function Point3D.new(x, y, z)
  local obj = {x = x, y = y, z = z}
  return setmetatable(obj, {__index = Point3D})
end

-- 距離を求める
function Point3D.distance(p1, p2)
  local dx = p1.x - p2.x
  local dy = p1.y - p2.y
  local dz = p1.z - p2.z
  return math.sqrt(dx * dx + dy * dy + dz * dz)
end



p1 = Point.new(0, 0)
p2 = Point.new(10, 10)
p3 = Point3D.new(0, 0, 0)
p4 = Point3D.new(10, 10, 10)

print(p1:distance(p2))
print(p3:distance(p4))
