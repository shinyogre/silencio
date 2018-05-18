FrameWidth,FrameHeight = love.graphics.getDimensions()
local timer = 0
local mousex, mousey


function love.load()
  shader = love.graphics.newShader('shader.fs')
  
end

function love.update(dt)
  timer = timer + dt
  mousex = love.mouse.getX()/FrameWidth
  mousey = love.mouse.getY()/FrameHeight
  print(mousex,mousey)
end



function love.draw()
  love.graphics.setShader(shader)
  shader:send("timer",timer)
  --shader:send("mouse",{mousex,mousey})
  love.graphics.rectangle("fill",0,0,FrameWidth,FrameHeight)
  love.graphics.setShader()
  love.graphics.print("FPS "..tostring(love.timer.getFPS()),10,10)
end
