--[[
There is a key "behind" a wall.  It is yellow.  On the other side of the wall, there is a yellow block and a red block.  The yellow block cannot pass through the wall, but the red block can.  The red block cannot collect the yellow key.  The red block and the yellow block must be snapped together in a way that matches the orientation of the wall, then both blocks can pass through.

An entity is an empty thing that has only a list of components.  e.g. a 'player' entity might contain a position, sprite, and control component.

Components just contain variables.  No methods.  SYSTEMS handle methods for components.  A world correlates systems with components.

]]

lg = love.graphics
rand = love.math.random
FrameWidth, FrameHeight = love.graphics.getDimensions()

function love.load()
end

function love.update(dt)
end

function love.draw()
end


