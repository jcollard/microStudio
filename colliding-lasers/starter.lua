-- ===== STAR FUNCTIONS =====

-- Custom function to initialize the stars
function init_stars()
  stars = {}
  for i = 1, 100 do  -- More stars!
    local star = {}
    star.x = (math.random() - 0.5) * screen.width
    star.y = (math.random() - 0.5) * screen.height

    -- Multiply two random numbers to bias toward smaller values
    star.speed = math.random() * math.random() * 1.5 + 0.5
    star.size = star.speed
    table.insert(stars, star)
  end
end

-- Custom function to update all the stars
function update_stars()
  for key, star in pairs(stars) do
    star.y = star.y - star.speed  -- Move down

    if star.y < -screen.height / 2 then  -- Gone off bottom edge?
      star.y = screen.height / 2  -- Reset to top edge
      star.x = (math.random() - 0.5) * screen.width  -- New random x
    end
  end
end

-- Custom function to draw all the stars
function draw_stars()
  for key, star in pairs(stars) do
    -- Calculate brightness based on speed (0.5 to 2.0)
    local brightness = (star.speed - 0.5) / 1.5  -- Normalize to 0-1
    local colorValue = 100 + brightness * 155  -- Range: 100-255

    screen:setColor("rgb(" .. colorValue .. "," .. colorValue .. "," .. colorValue .. ")")
    screen:fillRect(star.x, star.y, star.size, star.size)
  end
end

-- ===== PLAYER FUNCTIONS =====

-- Custom function to initialize the player
function init_player()
  x = 0
  y = -80
  rotation = 0
end

-- Custom function to update the player
function update_player()
  -- Reset rotation
  rotation = 0

  -- If the user presses left
  if keyboard.LEFT == 1 then
    -- move ship left and rotate the ship to the left
    x = x - 1
    rotation = 15
  end

  -- If the user presses right
  if keyboard.RIGHT == 1 then
    -- move ship right and rotate ship to the right
    x = x + 1
    rotation = -15
  end

  -- Keep the player's x position on the screen
  if x < -100 then x = -100 end
  if x > 100 then x = 100 end
end

-- Custom function to draw the player ship
function draw_player()
  screen:setDrawRotation(rotation)
  screen:drawSprite("player", x, y, 99*0.25, 75*0.25)
  screen:setDrawRotation(0)
end

-- ===== EYE FUNCTIONS =====

-- Custom function to initialize the googly eyes
function init_eyes()
  eye_rotation = 0

  left_eye_x = 0
  left_eye_y = 0
  left_eye_vx = 0.7
  left_eye_vy = 0.57575

  right_eye_x = 0
  right_eye_y = 0
  right_eye_vx = -0.6
  right_eye_vy = 0.37575
end

-- Custom function to update the googly eyes
function update_eyes()
  -- Rotate the eyes
  eye_rotation = eye_rotation + 12

  -- Make the left eye move
  left_eye_x = left_eye_x + left_eye_vx
  left_eye_y = left_eye_y + left_eye_vy

  -- Keep the left eye on the screen
  if left_eye_x < -100 then left_eye_vx = 0.7 end
  if left_eye_x > 100 then left_eye_vx = -0.7 end
  if left_eye_y < -100 then left_eye_vy = 0.57575 end
  if left_eye_y > 100 then left_eye_vy = -0.57575 end

  -- Make the right eye move
  right_eye_x = right_eye_x + right_eye_vx
  right_eye_y = right_eye_y + right_eye_vy

  -- Keep the right eye on the screen
  if right_eye_x < -100 then right_eye_vx = 0.6 end
  if right_eye_x > 100 then right_eye_vx = -0.6 end
  if right_eye_y < -100 then right_eye_vy = 0.37575 end
  if right_eye_y > 100 then right_eye_vy = -0.37575 end
end

-- Custom function to draw the googly eyes
function draw_eyes()
  screen:setDrawScale(1, 1)
  screen:setDrawRotation(eye_rotation)
  screen:drawSprite("googlya", left_eye_x, left_eye_y, 32, 32)
  screen:setDrawRotation(-eye_rotation)
  screen:drawSprite("googlyb", right_eye_x, right_eye_y, 32, 32)
end

-- ===== LASER FUNCTIONS =====

-- Custom function to initialize lasers
function init_lasers()
  lasers = {}
end

-- Custom function to create a new laser
function create_laser()
  laser = {}
  laser.x = 0
  laser.y = 200
  laser.vy = 2
  return laser
end

-- Custom function to move all lasers
function move_lasers()
  for ix, laser in pairs(lasers) do
    lasers[ix].y = lasers[ix].y + lasers[ix].vy
  end
end

-- Custom function to handle firing lasers
function fire_laser()
  if keyboard.press.SPACE == 1 then
    fired_laser = nil

    -- Find a laser that is off the screen
    for ix, laser in pairs(lasers) do
      if lasers[ix].y > 300 then
        fired_laser = lasers[ix]
      end
    end

    -- If we did not find a laser, we need to make one
    if fired_laser == nil then
      fired_laser = create_laser()
      table.insert(lasers, fired_laser)
    end

    -- Finally, move the laser in front of the ship
    fired_laser.y = y + 15
    fired_laser.x = x
  end
end

-- Custom function to draw all the lasers
function draw_lasers()
  for ix, laser in pairs(lasers) do
    screen:drawSprite("laser", lasers[ix].x, lasers[ix].y, 9*0.25, 37*0.25)
  end
end

-- ===== MAIN MICROSTUDIO FUNCTIONS =====

init = function()
  init_stars()
  init_player()
  init_eyes()
  init_lasers()
end

update = function()
  update_stars()
  update_player()
  update_eyes()
  move_lasers()
  fire_laser()
end

draw = function()
  screen:clear("rgb(0, 0, 20)")

  draw_stars()
  draw_eyes()
  draw_player()
  draw_lasers()
end
