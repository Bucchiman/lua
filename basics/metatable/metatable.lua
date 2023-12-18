#!/usr/bin/env lua
--
-- FileName:     metatable
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-24 22:29:22
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    http://www.nct9.ne.jp/m_hiroi/light/lua05.html
-- Description:  ---
--
--
--



Foo = {}

function Foo.get_a(self) return self.a end
function Foo.get_b(self) return self.b end
function Foo.set_a(self, x) self.a = x end
function Foo.set_b(self, x) self.b = x end

function Foo.new(a, b)
    local obj = {a = a, b = b}
    return setmetatable(obj, {__index = Foo})
end

x = Foo.new(10, 20)
print(x:get_a())
