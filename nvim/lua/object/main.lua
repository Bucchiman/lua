Foo = {}

-- メソッド定義
function Foo.get_a(self) return self.a end
function Foo.get_b(self) return self.b end
function Foo.set_a(self, x) self.a = x end
function Foo.set_b(self, x) self.b = x end

-- コンストラクタ
function Foo.new(a, b)
  local obj = {a = a, b = b}
  -- メタテーブルセット
  return setmetatable(obj, {__index = Foo})
end

x = Foo.new(10, 20)
print(x:get_a())
print(x:get_b())

x:set_a(100)
print(x:get_a())
