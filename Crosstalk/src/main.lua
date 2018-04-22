lg = love.graphics
FrameWidth = love.graphics.getWidth()
FrameHeight = love.graphics.getHeight()
rand = love.math.random
require 'start'
require 'shapes'
Gamestate = require "libs.hump.gamestate"

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(start)
end

--******************Check for AABB or mouse collisions (not by me)********************
function CheckCollisionBox(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function CheckCollisionMouse(x1,y1,x2,y2,w,h)
  return x1 < x2+w and
         x2 < x1 and
         y1 < y2+h and
         y2 < y1
end

function MeasureDistance(partA,partB)
  local distance = math.sqrt((partA.x-partB.x)^2 + (partA.y - partB.y)^2)
  return distance, partA.x,partA.y,partB.x,partB.y
end

--********************************************************************************

