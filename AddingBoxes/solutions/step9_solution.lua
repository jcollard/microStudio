-- ============================================
-- SOLUTION FOR STEP 9: REFACTOR TO WIDTH AND HEIGHT
-- ============================================
-- This file shows the complete solution after finishing Step 9
-- All bounding boxes now use width/height instead of size!
-- Based on colliding-lasers/starter.lua

-- --------------------------------------------
-- STEP 9: Create Box Function with Width and Height
-- --------------------------------------------
-- Custom function to create a bounding box object
function create_box(x, y, width, height, vx, vy, color)
  local new_box = {
    x = x,
    y = y,
    width = width,
    height = height,
    vx = vx,
    vy = vy,
    color = color,
    original_color = color
  }
  return new_box
end

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

-- --------------------------------------------
-- STEP 9: Initialize Player with Width and Height
-- --------------------------------------------
-- Custom function to initialize the player
function init_player()
  -- STEP 9 SOLUTION: Player now uses width and height (25x25)
  player = create_box(0, -80, 25, 25, 0, 0, "#00FF00")

  -- Keep rotation separate (not part of box)
  rotation = 0
end

-- Custom function to update the player
function update_player()
  -- Reset rotation
  rotation = 0

  -- If the user presses left
  if keyboard.LEFT == 1 then
    -- move ship left and rotate the ship to the left
    player.x = player.x - 1
    rotation = 15
  end

  -- If the user presses right
  if keyboard.RIGHT == 1 then
    -- move ship right and rotate ship to the right
    player.x = player.x + 1
    rotation = -15
  end

  -- Keep the player's x position on the screen
  if player.x < -100 then player.x = -100 end
  if player.x > 100 then player.x = 100 end
end

-- --------------------------------------------
-- STEP 9: Draw Player with Width and Height
-- --------------------------------------------
-- Custom function to draw the player ship
function draw_player()
  -- Ensure no rotation for bounding box
  screen:setDrawRotation(0)

  -- STEP 9 SOLUTION: Draw player bounding box using width and height
  screen:setColor(player.color)
  screen:fillRect(player.x, player.y, player.width, player.height)

  -- Draw the actual player sprite on top of the bounding box with rotation
  screen:setDrawRotation(rotation)
  screen:drawSprite("player", player.x, player.y, 99*0.25, 75*0.25)
  screen:setDrawRotation(0)
end

-- ===== EYE FUNCTIONS =====

-- --------------------------------------------
-- STEP 9: Initialize Eyes with Width and Height
-- --------------------------------------------
-- Custom function to initialize the googly eyes
function init_eyes()
  eye_rotation = 0

  -- STEP 9 SOLUTION: Left eye uses width and height (32x32)
  left_eye = create_box(0, 0, 32, 32, 0.7, 0.57575, "#FF00FF")

  -- STEP 9 SOLUTION: Right eye uses width and height (32x32)
  right_eye = create_box(0, 0, 32, 32, -0.6, 0.37575, "#00FFFF")
end

-- Custom function to update the googly eyes
function update_eyes()
  -- Rotate the eyes
  eye_rotation = eye_rotation + 12

  -- Left eye movement using box properties
  left_eye.x = left_eye.x + left_eye.vx
  left_eye.y = left_eye.y + left_eye.vy

  -- Left eye boundary checks using box properties
  if left_eye.x < -100 then left_eye.vx = 0.7 end
  if left_eye.x > 100 then left_eye.vx = -0.7 end
  if left_eye.y < -100 then left_eye.vy = 0.57575 end
  if left_eye.y > 100 then left_eye.vy = -0.57575 end

  -- Right eye movement using box properties
  right_eye.x = right_eye.x + right_eye.vx
  right_eye.y = right_eye.y + right_eye.vy

  -- Right eye boundary checks using box properties
  if right_eye.x < -100 then right_eye.vx = 0.6 end
  if right_eye.x > 100 then right_eye.vx = -0.6 end
  if right_eye.y < -100 then right_eye.vy = 0.37575 end
  if right_eye.y > 100 then right_eye.vy = -0.37575 end
end

-- --------------------------------------------
-- STEP 9: Draw Eyes with Width and Height
-- --------------------------------------------
-- Custom function to draw the googly eyes
function draw_eyes()
  -- STEP 9 SOLUTION: Draw left eye bounding box using width and height
  screen:setColor(left_eye.color)
  screen:fillRect(left_eye.x, left_eye.y, left_eye.width, left_eye.height)

  -- STEP 9 SOLUTION: Draw right eye bounding box using width and height
  screen:setColor(right_eye.color)
  screen:fillRect(right_eye.x, right_eye.y, right_eye.width, right_eye.height)

  -- Draw the actual eye sprites on top of the bounding boxes
  screen:setDrawScale(1, 1)
  screen:setDrawRotation(eye_rotation)
  screen:drawSprite("googlya", left_eye.x, left_eye.y, 32, 32)
  screen:setDrawRotation(-eye_rotation)
  screen:drawSprite("googlyb", right_eye.x, right_eye.y, 32, 32)
end

-- ===== LASER FUNCTIONS =====

-- Custom function to initialize lasers
function init_lasers()
  lasers = {}
end

-- --------------------------------------------
-- STEP 9: Create Laser with Width and Height
-- --------------------------------------------
-- Custom function to create a new laser
function create_laser()
  -- STEP 9 SOLUTION: Lasers now use width and height (8x8)
  return create_box(0, 200, 8, 8, 0, 2, "#FF0000")
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
    fired_laser.y = player.y + 15
    fired_laser.x = player.x
  end
end

-- --------------------------------------------
-- STEP 9: Draw Lasers with Width and Height
-- --------------------------------------------
-- Custom function to draw all the lasers
function draw_lasers()
  for ix, laser in pairs(lasers) do
    -- STEP 9 SOLUTION: Draw laser bounding box using width and height
    screen:setColor(lasers[ix].color)
    screen:fillRect(lasers[ix].x, lasers[ix].y, lasers[ix].width, lasers[ix].height)

    -- Draw the actual laser sprite on top of the bounding box
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

-- ============================================
-- WHAT'S NEXT?
-- ============================================
-- Now that we have a flexible bounding box system with width/height:
-- 1. We're ready to implement collision detection!
-- 2. Add the boxes_colliding() function
-- 3. Detect laser-eye collisions
-- 4. Add collision response (remove eyes when hit)
-- ============================================
