-- Configuration
function love.conf(t)
	t.title = "Snake" -- The title of the window the game is in (string)
	t.version = "0.8.0"         -- The LÖVE version this game was made for (string)
	t.screen.width = 400
	t.screen.height = 400
	t.modules.joystick = false
  t.modules.physics = false

end
