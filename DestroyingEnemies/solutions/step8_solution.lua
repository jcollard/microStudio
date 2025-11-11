-- ============================================
-- SOLUTION FOR STEP 8: COMPLETE GAME
-- ============================================
-- This file shows the complete, final solution for the Destroying Enemies challenge
-- All features are implemented: state management, movement control, drawing control,
-- and collision detection with proper response
-- Based on step7_solution.lua

function create_box(x, y, width, height, vx, vy, color)
  local new_box = {
    x = x, y = y,
    width = width, height = height,
    vx = vx, vy = vy,
    color = color, original_color = color
  }
  return new_box
end

function draw_box(b)
  screen:setColor(b.color)
  screen:fillRect(b.x, b.y, b.width, b.height)
end

-- ===== COLLISION DETECTION =====

function boxes_colliding(box1, box2)
  -- Calculate edges of box1
  local box1_left = box1.x - box1.width / 2
  local box1_right = box1.x + box1.width / 2
  local box1_bottom = box1.y - box1.height / 2
  local box1_top = box1.y + box1.height / 2

  -- Calculate edges of box2
  local box2_left = box2.x - box2.width / 2
  local box2_right = box2.x + box2.width / 2
  local box2_bottom = box2.y - box2.height / 2
  local box2_top = box2.y + box2.height / 2

  -- Check if boxes overlap on both axes
  if box1_right > box2_left and
     box1_left < box2_right and
     box1_top > box2_bottom and
     box1_bottom < box2_top then
    return true  -- Boxes are colliding!
  end

  return false  -- No collision
end

function check_collisions()
  -- Check each laser
  for ix, laser in pairs(lasers) do
    -- Check left eye if not already destroyed
    if not left_eye.isDestroyed then
      if boxes_colliding(laser, left_eye) then
        left_eye.isDestroyed = true
      end
    end

    -- Check right eye if not already destroyed
    if not right_eye.isDestroyed then
      if boxes_colliding(laser, right_eye) then
        right_eye.isDestroyed = true
      end
    end
  end
end

-- ===== EYE FUNCTIONS =====

function init_eyes()
  eye_rotation = 0

  left_eye = create_box(0, 0, 28, 28, 0.7, 0.57575, "#FF00FF")
  left_eye.isDestroyed = false

  right_eye = create_box(0, 0, 28, 28, -0.6, 0.37575, "#00FFFF")
  right_eye.isDestroyed = false
end

function update_eyes()
  eye_rotation = eye_rotation + 12

  -- Left eye - ONLY UPDATE IF NOT DESTROYED
  if not left_eye.isDestroyed then
    left_eye.x = left_eye.x + left_eye.vx
    left_eye.y = left_eye.y + left_eye.vy

    if left_eye.x < -100 then left_eye.vx = 0.7 end
    if left_eye.x > 100 then left_eye.vx = -0.7 end
    if left_eye.y < -100 then left_eye.vy = 0.57575 end
    if left_eye.y > 100 then left_eye.vy = -0.57575 end
  end

  -- Right eye - ONLY UPDATE IF NOT DESTROYED
  if not right_eye.isDestroyed then
    right_eye.x = right_eye.x + right_eye.vx
    right_eye.y = right_eye.y + right_eye.vy

    if right_eye.x < -100 then right_eye.vx = 0.6 end
    if right_eye.x > 100 then right_eye.vx = -0.6 end
    if right_eye.y < -100 then right_eye.vy = 0.37575 end
    if right_eye.y > 100 then right_eye.vy = -0.37575 end
  end
end

function draw_eyes()
  -- Left eye - ONLY DRAW IF NOT DESTROYED
  if not left_eye.isDestroyed then
    draw_box(left_eye)
    screen:setDrawScale(1, 1)
    screen:setDrawRotation(eye_rotation)
    screen:drawSprite("googlya", left_eye.x, left_eye.y, 32, 32)
  end

  -- Right eye - ONLY DRAW IF NOT DESTROYED
  if not right_eye.isDestroyed then
    screen:setDrawRotation(-eye_rotation)
    screen:drawSprite("googlyb", right_eye.x, right_eye.y, 32, 32)
  end

  screen:setDrawRotation(0)
end

-- ===== STAR FUNCTIONS =====

function init_stars()
  stars = {}
  for i = 1, 100 do
    local star = {}
    star.x = (math.random() - 0.5) * screen.width
    star.y = (math.random() - 0.5) * screen.height
    star.speed = math.random() * math.random() * 1.5 + 0.5
    star.size = star.speed
    table.insert(stars, star)
  end
end

function update_stars()
  for key, star in pairs(stars) do
    star.y = star.y - star.speed
    if star.y < -screen.height / 2 then
      star.y = screen.height / 2
      star.x = (math.random() - 0.5) * screen.width
    end
  end
end

function draw_stars()
  for key, star in pairs(stars) do
    local brightness = (star.speed - 0.5) / 1.5
    local colorValue = 100 + brightness * 155
    screen:setColor("rgb(" .. colorValue .. "," .. colorValue .. "," .. colorValue .. ")")
    screen:fillRect(star.x, star.y, star.size, star.size)
  end
end

-- ===== PLAYER FUNCTIONS =====

function init_player()
  player = create_box(0, -80, 25, 25, 0, 0, "#00FF00")
  rotation = 0
end

function update_player()
  rotation = 0

  if keyboard.LEFT == 1 then
    player.x = player.x - 1
    rotation = 15
  end

  if keyboard.RIGHT == 1 then
    player.x = player.x + 1
    rotation = -15
  end

  if player.x < -100 then player.x = -100 end
  if player.x > 100 then player.x = 100 end
end

function draw_player()
  screen:setDrawRotation(0)
  draw_box(player)
  screen:setDrawRotation(rotation)
  screen:drawSprite("player", player.x, player.y, 99*0.25, 75*0.25)
  screen:setDrawRotation(0)
end

-- ===== LASER FUNCTIONS =====

function init_lasers()
  lasers = {}
end

function create_laser()
  return create_box(0, 200, 2, 8, 0, 2, "#FF0000")
end

function move_lasers()
  for ix, laser in pairs(lasers) do
    lasers[ix].y = lasers[ix].y + lasers[ix].vy
  end
end

function fire_laser()
  if keyboard.press.SPACE == 1 then
    fired_laser = nil

    for ix, laser in pairs(lasers) do
      if lasers[ix].y > 300 then
        fired_laser = lasers[ix]
      end
    end

    if fired_laser == nil then
      fired_laser = create_laser()
      table.insert(lasers, fired_laser)
    end

    fired_laser.y = player.y + 15
    fired_laser.x = player.x
  end
end

function draw_lasers()
  for ix, laser in pairs(lasers) do
    draw_box(lasers[ix])
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
  check_collisions()
end

draw = function()
  screen:clear("rgb(0, 0, 20)")

  draw_stars()
  draw_eyes()
  draw_player()
  draw_lasers()
end
