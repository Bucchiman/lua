#!/usr/bin/env lua
--
-- FileName:     main
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-08-20 23:04:57
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath
--               https://github.com/CharlesChiuGit/nvimdots.lua
-- Description:  ---
--


-- function love.draw ()
--     love.graphics.setColor(.14, .36, .46)
--     love.graphics.rectangle('fill', 0, 0, 300, 388)
-- end


-- function love.draw ()
--     love.graphics.setColor(.87, .84, .27)
--     love.graphics.rectangle('fill', 62, 200, 30, 25)
-- end


-- function love.load()
--     birdY = 200
-- end
-- 
-- function love.update(dt)
--     birdY = birdY + (30 * dt)
-- end
-- 
-- function love.draw()
--     -- etc.
-- 
--     love.graphics.setColor(.87, .84, .27)
--     love.graphics.rectangle('fill', 62, birdY, 30, 25)
-- end

function love.load()
    birdY = 200
    birdYSpeed = 0
end

function love.update(dt)
    birdYSpeed = birdYSpeed + (516 * dt)
    birdY = birdY + (birdYSpeed * dt)
end
