FrameWidth,FrameHeight = love.graphics.getDimensions()
local timer = 0

function love.load()
  shader = love.graphics.newShader('shader.fs')
  
end

function love.update(dt)
    timer = timer + dt
  
  print(timer)
end



function love.draw()
  love.graphics.setShader(shader)
  shader:send('time',timer)
  love.graphics.rectangle("fill",FrameWidth/2-50,FrameHeight/2-50,100,100)
  love.graphics.setShader()
end
