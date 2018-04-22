for i,shape in ipairs(shapes) do
  for j = i+1, #shapes do
    local otherShape = shapes[j]
    print(Difference(shape,otherShape))
    if Difference[2] <= 50 then
      --do stuff
    end
  end
end

shapes = {}
local mt = {
  __eq = function(l, r)
    return l.foo == r.foo and l.bar == r.bar
  end
}


function shapes:generate()
  local img = shape_img
  local opacity = {85,255}
  local randOpacity = opacity[rand(1,2)]
  local color = {r = {255,0,0,randOpacity}, g = {0,255,0,randOpacity}, b ={0,0,255,randOpacity},y = {255,255,0,randOpacity}}
  local rot = {0,math.pi/4}
  local group = rand(1,3)
  local scale = rand(1,2)
  local channel = {"r","g","b","y"}
  local randColor = color[channel[rand(1,4)]
  local randRot = rot[rand(1,2)]
  local x = rand(32,FrameWidth-32) -- need to be not random
  local y = rand(32,FrameHeight-32) -- need to be not random
  local dragging = {active = false, diffX = 0, diffY = 0}
  return group,scale,randColor,randOpacity,randRot,x,y,img, dragging, dragging.active, dragging.diffX, dragging.diffY
end

function shapes:load()
  shape = {shapes:generate()}
  table.insert(shapes,shape)
  setmetatable(shape,mt)
end

function shapes:update(dt)
  for i, shape in ipairs(shapes) do
    print(shapes[1] == shapes[2])
  end
end



function shapes:draw()
  for i, shape in ipairs(shapes) do
    lg.setColor(shape[3])
    lg.draw(shape[8],shape[6],shape[7],shape[5],shape[2],shape[2])
    for j = i+1, #shapes do
        local otherShape = shapes[j]
        local distlines = {MeasureDistance(shape, otherShape)}
        lg.line(distlines[2],distlines[3],distlines[4],distlines[5])
    end 
  end
end