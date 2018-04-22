--io.stdout:setvbuf("no") -- remove before release

function love.conf(t)
  t.window.title = "Crosstalk"
  t.version = "0.10.1"
  t.window.width = 1280
  t.window.height = 720
  t.window.fullscreen = false
  t.window.display = 1
  t.window.msaa = 0
  t.window.vsync = true
  --t.window.icon = ""
  --love.filesystem.setIdentity("")
end