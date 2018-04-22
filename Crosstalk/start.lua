start = {}
local mousex, mousey

function start:init()
end

function start:enter()
  btn = {
    s = {x = FrameWidth/2-128,y=FrameHeight/2,w=128,h=64},
    q = {x = FrameWidth/2,y=FrameHeight/2,w=128,h=64}
  }
end

function start:update(dt)
  mousex = love.mouse.getX()
  mousey = love.mouse.getY()
end

function start:mousepressed()
  if CheckCollisionMouse(mousex,mousey,btn.s.x,btn.s.y,btn.s.w,btn.s.h) then
    Gamestate.switch(shapes)
  elseif CheckCollisionMouse(mousex,mousey,btn.q.x,btn.q.y,btn.q.w,btn.q.h) then
    love.event.quit()
  end
end

function start:keypressed(key)
  if key == 'space' then
    Gamestate.switch(shapes)
  end
end


function start:draw()
  lg.setBackgroundColor(255,255,255)
  lg.setColor(0,255,0)
  lg.rectangle('fill',btn.s.x-32,btn.s.y,btn.s.w,btn.s.h)
  lg.setColor(255,0,0)
  lg.rectangle('fill',btn.q.x+32,btn.q.y,btn.q.w,btn.q.h)
  lg.setColor(0,0,0)
  lg.print("start",btn.s.x+24,btn.s.y+24)
  lg.print("quit",btn.q.x+80,btn.q.y+24)
  lg.print("Headphones are recommended...",FrameWidth/2-100,200)
  lg.print("Click + Drag the squares.  Press SPACE to reset.",FrameWidth/2-100,300)
  lg.print("Listen and watch...",FrameWidth/2-100,500)
end
