--[[
There is a key "behind" a wall.  It is yellow.  On the other side of the wall, there is a yellow block and a red block.  The yellow block cannot pass through the wall, but the red block can.  The red block cannot collect the yellow key.  The red block and the yellow block must be snapped together in a way that matches the orientation of the wall, then both blocks can pass through.

An entity is an empty thing that has only a list of components.  e.g. a 'player' entity might contain a position, sprite, and control component.

Components just contain variables.  No methods.  SYSTEMS have methods for components.  A world correlates systems with components.



lg = love.graphics
rand = love.math.random
FrameWidth, FrameHeight = love.graphics.getDimensions()

function love.load()
end

function love.update(dt)
end

function love.draw()
end
]]

local tiny = require("lib.tiny")

local talkingSystem = tiny.processingSystem()
local movementSystem = tiny.processingSystem()
talkingSystem.filter = tiny.requireAll("name", "mass", "phrase")
movementSystem.filter = tiny.requireAll("x","y","dir")

function talkingSystem:process(e, dt)
    e.mass = e.mass + dt * 3
    print(("%s who weighs %d pounds, says %q."):format(e.name, e.mass, e.phrase))
end

function movementSystem:process(e,dt)
  if love.keyboard.isDown('right') then
    e.x = e.x + 1
  elseif love.keyboard.isDown('left') then
    e.x = e.x - 1
  elseif love.keyboard.isDown('up') then
    e.y = e.y - 1
  elseif love.keyboard.isDown('down') then
    e.y = e.y + 1
  end
  
  e.dir = 1
  print(e.x, e.y)
end

local joe = {
    name = "Joe",
    phrase = "I'm a plumber.",
    mass = 150,
    hairColor = "brown",
    x = 0,
    y = 0,
    dir = 0
}

local world = tiny.world(talkingSystem,movementSystem, joe)

function talk()
  talkingSystem:update(1)
end

function love.keypressed(key)
  if key == 'space' then
    talk()
  end
end


function love.update(dt)
  world:update(1)
end


