--what if I combine voronoi tesselation with a shader?
FrameWidth,FrameHeight = love.graphics.getDimensions()
local moonshine = require 'lib.moonshine'
local effect = nil
local image = love.graphics.newImage('test.jpg')



function love.load()
 effect = moonshine(moonshine.effects.sketch)
  effect.sketch.amp = 0.09
end




function love.draw()
  effect(function()
    love.graphics.draw(image,FrameWidth/2,FrameHeight/2,0,0.5,0.5,image:getWidth()/2,image:getHeight()/2)
  end)
end
