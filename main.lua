FrameWidth,FrameHeight = love.graphics.getDimensions()
local timer,sign,motion = 0,1,0
local toggle = false
local mousex, mousey
local scaler = love.math.newTransform(0,0,0,1,1,0,0)


function love.load()
  shader = love.graphics.newShader('colorpractice.fs')
  
end

function love.update(dt)
  local t = 1
  if sign == 1 then
    t = timer + dt
  else
    t = timer - dt
  end
  
  timer = math.max(math.min(t,1),0)
  if timer ~= t then
    sign = sign * (-1)
  end
  t = timer * sign
  motion = lerp(0,1,t)
  
  
  mousex = love.mouse.getX()/FrameWidth
  mousey = love.mouse.getY()/FrameHeight
  print(mousex,mousey,motion, timer, t)
end



function love.draw()
  love.graphics.setShader(shader)
  --shader:send("motion",motion)
  --shader:send("mouse",{mousex,mousey})
  shader:send("scaler",scaler)
  love.graphics.rectangle("fill",0,0,FrameWidth,FrameHeight)
  love.graphics.setShader()
  love.graphics.setColor(1,0,0)
  love.graphics.print("FPS "..tostring(love.timer.getFPS()),10,10)
end


function lerp(a,b,t)
  t = math.max(math.min(timer,1),0)
  return a + (b-a) * t
end
