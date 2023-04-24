-- metatable.lua

-- v をテーブルとして初期化する
v = {name="feifei", age=28, sex="male"}

-- メタテーブルを追加する
setmetatable(v, {memo1="test1", memo2="test2"})

-- v の値を列挙する
print "*** values"

for key, val in pairs(v) do
   print(key, val)
end

-- meta テーブルを取得して列挙する
print "*** metatables"
meta = getmetatable(v)

for key, val in pairs(meta) do
   print(key, val)
end
