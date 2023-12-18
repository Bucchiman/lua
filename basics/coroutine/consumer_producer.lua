#!/usr/bin/env lua
--
-- FileName:     consumer_producer
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-06-24 15:47:56
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://www.lua.org/pil/9.2.html
-- Description:  ---
--


function receive (prod)
  local status, value = coroutine.resume(prod)
  return value
end

function send (x)
  coroutine.yield(x)
end

function producer ()
  return coroutine.create(function ()
    while true do
      local x = io.read()     -- produce new value
      send(x)
    end
  end)
end

function filter (prod)
  return coroutine.create(function ()
    local line = 1
    while true do
      local x = receive(prod)   -- get new value
      x = string.format("%5d %s", line, x)
      send(x)      -- send it to consumer
      line = line + 1
    end
  end)
end

function consumer (prod)
  while true do
    local x = receive(prod)   -- get new value
    io.write(x, "\n")          -- consume new value
  end
end
--The final bit simply creates the components it needs, connects them, and starts the final consumer:
p = producer()
f = filter(p)
consumer(f)

