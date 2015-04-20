debug = true

bodyImg = nil
bodyTable = {} --array of snake body pieces

canMove = true
canMoveTimerMax = .2
canMoveTimer = canMoveTimerMax

length = 1
string = "Length: "

direction = "right"

function love.load(arg)
  love.graphics.setBackgroundColor( 0, 6, 86 )
  head = { x = 100, y = 100, oldx = nil, oldy = nil, speed = 1, img = nil }
  head.img = love.graphics.newImage('assets/head.png')
  bodyImg = love.graphics.newImage('assets/body.png')

  foodImg = love.graphics.newImage('assets/food.png')
  food = { x = 200, y = 200, img = foodImg }
end

function love.update(dt)
  -- 'Esc' to exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end


  -- Time out how far apart our body creates can be
  canMoveTimer = canMoveTimer - (1 * dt)
  if canMoveTimer < 0 then
    canMove = true
  end
 -- Change direction
  if love.keyboard.isDown('left','a') and direction ~= "right" then
    direction = "left"
  elseif love.keyboard.isDown('right','d') and direction ~= "left" then
    direction = "right"
  elseif love.keyboard.isDown('up','w') and direction ~= "down" then
    direction = "up"
  elseif love.keyboard.isDown('down','s') and direction ~= "up" then
    direction = "down"
  end

-- check for collisions
  if collisionCheck() then
    head.speed = 0
    string = "Game Over. Score: "
    love.graphics.setBackgroundColor( 252, 73, 94 )
  end


 --head movement--
	if direction == "left" and canMove then
    if head.x > 0 then --update head
      head.oldx = head.x
      head.oldy = head.y
      head.x = head.x - 20*head.speed
      updateBody()
      canMove = false
  	  canMoveTimer = canMoveTimerMax
    end
	elseif direction == "right" and canMove then
    if head.x < (love.graphics.getWidth() - head.img:getWidth()) then --update head
      head.oldx = head.x
      head.oldy = head.y
      head.x = head.x + 20*head.speed
      updateBody()
      canMove = false
  	  canMoveTimer = canMoveTimerMax
    end
  elseif direction == "up" and canMove then
    if head.y > 0 then --update head
      head.oldx = head.x
      head.oldy = head.y
      head.y = head.y - 20*head.speed
      updateBody()
      canMove = false
  	  canMoveTimer = canMoveTimerMax
    end
  elseif direction == "down" and canMove then
    if head.y < (love.graphics.getHeight() - head.img:getHeight()) then --update head
      head.oldx = head.x
      head.oldy = head.y
      head.y = head.y + 20*head.speed
      updateBody()
      canMove = false
  	  canMoveTimer = canMoveTimerMax
    end
	end


  -- Check is food is eaten
  if foodEaten() then
    newBody = { x = -40 , y = 0, oldx = nil, oldy = nil, img = bodyImg }
    table.insert(bodyTable, newBody)
    placeFood()
    length = length + 1
  end



end

function love.draw(dt)
  love.graphics.draw(head.img, head.x, head.y)

  for i, body in ipairs(bodyTable) do
      love.graphics.draw(body.img, body.x, body.y)
  end

  love.graphics.draw(food.img, food.x, food.y)

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print(string .. length, 0, 0, 0, 1.5, 1.5)
end

function updateBody()
  for i, body in ipairs(bodyTable) do --update snake body
    if i == 1 then
      body.oldx = body.x
      body.oldy = body.y
      body.x = head.oldx
      body.y = head.oldy
    else
      body.oldx = body.x
      body.oldy = body.y
      body.x = bodyTable[i-1].oldx
      body.y = bodyTable[i-1].oldy
    end
  end
end

function collisionCheck() --returns true if collisions
  for i, body in ipairs(bodyTable) do
    if body.x == head.x and body.y == head.y then
      return true
    end
  end
  return false
end

function placeFood() --sets new coordinates to food
  x = math.random(0,19)*20
  y = math.random(0,19)*20
  food.x = x
  food.y = y
end

function foodEaten() --returns true if head on food
  if head.x == food.x and head.y == food.y then
    return true
  end
  return false
end
