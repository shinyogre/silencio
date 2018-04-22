--[[
*create black bar, 2 squares, and 1 collectible
*click and drag +  click and place
*create snap-to-shape-edge behavior

]]

lg = love.graphics
rand = love.math.random
FrameWidth, FrameHeight = love.graphics.getDimensions()

function love.load()
end

function love.update(dt)
end

function love.draw()
  lg.setBackgroundColor(1,1,1)
  lg.setColor(0,0,0)
  lg.rectangle('fill',450,0,64,720)
end
