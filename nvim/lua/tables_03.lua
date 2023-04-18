-- metatable2.lua
-- テーブル同士の足し算を定義

function table_sub(a, b)
   local c = {}
   for key, val in pairs(a) do
      c[key] = val
   end
   for key, val in pairs(b) do
      c[key] = val
   end
   return c
end

-- テーブルを作成
t1 = {a = 1, b = 2, c = 3}
t2 = {d = 4, e = 5, f = 6}

-- メタテーブルを定義
setmetatable(t1, {__sub=table_sub}) -- __add を使わなければならない

-- テーブル同士の足し算を行って結果を表示
t3 = t1 - t2

for i, v in pairs(t3) do
   print(i, v)
end
