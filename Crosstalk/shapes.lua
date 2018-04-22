shapes = {}
local shape_img = lg.newImage("shape.png")
local wolrdmood = 0
local noise = love.audio.newSource("whitenoise.wav")
local anim8 = require 'libs.anim8'
local bg = lg.newImage('noise.jpg')

function shapes:generate()
  local channel = {"r","g","b","y"}
  local opacity = {100,255}
  local colortable = {r = {255,0,0,opacity[rand(1,2)]}, g = {0,255,0,opacity[rand(1,2)]}, b = {0,0,255,opacity[rand(1,2)]}, y = {255,255,0,opacity[rand(1,2)]}}
  local img = shape_img
  local scale = rand(1,2)
  local color = colortable[channel[rand(1,4)]]
  local x = rand(32,FrameWidth-32)
  local y = rand(32,FrameHeight-32)
  local w = 32*scale
  local h = 32*scale
  local rotationtable = {0,math.pi/4}
  local rot = rotationtable[rand(1,2)]
  local drag = {active = false, diffX = 0, diffY = 0}
  local mood = 0
  local bubble = 150
  return img,color,scale,x,y,w,h,drag,drag.active,drag.diffX,drag.diffY,mood,bubble,rot
  --return shape = {img,color,scale,x,y,w,h,drag,drag.active,drag.diffX,drag.diffY,mood,bubble,rot}
end

function shapes:load()
  
  shape = {shapes:generate()}
  shape.img = shape[1]
  shape.color = shape[2]
  shape.scale = shape[3]
  shape.x = shape[4]
  shape.y = shape[5]
  shape.w = shape[6]
  shape.h = shape[7]
  shape.drag = shape[8]
  shape.drag.active = shape[9]
  shape.drag.diffX = shape[10]
  shape.drag.diffY = shape[11]
  shape.mood = shape[12]
  shape.bubble = 150
  shape.rot = shape[14] ]]--
  table.insert(shapes,shape)
end

function shapes:difference(shapeA,shapeB)
  local mood = 0
  local radius = 300
  local distance = math.min(MeasureDistance(shapeA,shapeB),radius)
  --scale
  if shapeA.scale - shapeB.scale ~= 0 then
    mood = math.min(distance/radius,1)
  elseif shapeA.scale - shapeB.scale == 0 then
    mood = math.min((radius-distance)/radius,1)
  end
  
  --rotation
  if shapeA.rot - shapeB.rot ~= 0 then
    mood = math.min(distance/radius,1)
  elseif shapeA.rot - shapeB.rot == 0 then
    mood = math.min((radius-distance)/radius,1)
  end
  
  --color
  if shapeA.color[1] == shapeB.color[1] then
    if shapeA.color[2] == shapeB.color[2] then
      if shapeA.color[3] == shapeB.color[3] then
        mood = math.min((radius-distance)/radius,1)
      end
    end
  end
  
  --opacity
  if shapeA.color[4] == shapeB.color[4] then
    mood = math.min((radius-distance)/radius,1)
  elseif shapeA.color[4] ~= shapeB.color[4] then
    mood = math.min(distance/radius,1)
  end
  
  return mood
end


function shapes:enter(previous)
  love.audio.setVolume(0)
  love.audio.play(noise)
  noise:setLooping(true)
  local bgGrid = anim8.newGrid(1280,720,bg:getWidth(), bg:getHeight())
  animation = anim8.newAnimation(bgGrid('1-6',1), 0.09)
  
  for i=1, 6 do
    shapes:load()
  end
end

function shapes:update(dt)
  animation:update(dt)
  worldmood = 0
  for i=1, #shapes do
    local shape = shapes[i]
    if shape.drag.active then
      shape.x = love.mouse.getX() - shape.drag.diffX
      shape.y = love.mouse.getY() - shape.drag.diffY
    end
    shape.mood = 0
    for j = 1, #shapes do
      if i ~= j then
        local otherShape = shapes[j]
        local mood = shapes:difference(shape,otherShape)
        shape.mood = shape.mood + mood
        --print(MeasureDistance(shape,otherShape))
      end
    end
    shape.mood = shape.mood/(#shapes-1)
    worldmood = worldmood + shape.mood + 0.2
  end
  worldmood = worldmood/#shapes
  love.audio.setVolume(1-(worldmood))
  --print(worldmood)
end

function shapes:keypressed(key)
  if key == 'space' then
    for i=1, #shapes do
      table.remove(shapes,1)
    end
    shapes:enter()
  end
end


function shapes:mousepressed(x,y,button)
  for i, shape in ipairs(shapes) do
    if button == 1
    and x > shape.x-shape.w/2 and x < shape.x + shape.w/2
    and y > shape.y-shape.h/2 and y < shape.y + shape.h/2
    then
      shape.drag.active = true
      shape.drag.diffX = x - shape.x
      shape.drag.diffY = y - shape.y
    end
  end
end

function shapes:mousereleased(x,y,button)
  for i, shape in ipairs(shapes) do
    if button == 1 then shape.drag.active = false end
  end
end

function shapes:draw()
  animation:draw(bg,0,0)
  for i, shape in ipairs(shapes) do
    lg.setColor(shape.color)
    lg.draw(shape.img,shape.x,shape.y,shape.rot,shape.scale,shape.scale,(shape.w/2)/shape.scale,(shape.h/2)/shape.scale)
    for j = i+1, #shapes do
      local otherShape = shapes[j]
      local distlines = {MeasureDistance(shape,otherShape)}
      lg.line(distlines[2],distlines[3],distlines[4],distlines[5])
    end
    lg.setColor(0,0,0)
    --lg.print(tostring(shape.mood),shape.x,shape.y)
    lg.setColor(255,255,255,255)
  end
end