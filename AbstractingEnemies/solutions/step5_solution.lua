-- ============================================
-- SOLUTION FOR STEP 5: ADD COLLISION DETECTION
-- ============================================
-- This step adds laser-enemy collision detection
-- Includes all code from Step 4

enemies = {}

function create_enemy(sprite_name, width, height)
  local enemy = create_box(0, 0, width, height, 0, 0, "#FF0000")
  enemy.sprite = sprite_name
  enemy.rotation = 0
  enemy.rotation_speed = 0
  enemy.isDestroyed = false
  table.insert(enemies, enemy)
  return enemy
end

function init_enemies()
  enemies = {}

  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = 50
  enemy.y = 50
  enemy.vx = 0.5
  enemy.vy = 0.3
end

function draw_enemies()
  local enemy = enemies[1]
  if not enemy.isDestroyed then
    draw_box(enemy)
    screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
  end
end

function update_enemies()
  local enemy = enemies[1]
  if not enemy.isDestroyed then
    enemy.x = enemy.x + enemy.vx
    enemy.y = enemy.y + enemy.vy

    if enemy.x < -100 then enemy.vx = -enemy.vx end
    if enemy.x > 100 then enemy.vx = -enemy.vx end
    if enemy.y < -100 then enemy.vy = -enemy.vy end
    if enemy.y > 100 then enemy.vy = -enemy.vy end
  end
end

-- ===== NEW: COLLISION DETECTION =====

function check_collisions()
  for ix, laser in pairs(lasers) do
    -- Check collisions between lasers and eyes
    if not left_eye.isDestroyed then
      if boxes_colliding(laser, left_eye) then
        left_eye.isDestroyed = true
      end
    end

    if not right_eye.isDestroyed then
      if boxes_colliding(laser, right_eye) then
        right_eye.isDestroyed = true
      end
    end

    -- Check collisions between lasers and the first enemy (NEW!)
    local enemy = enemies[1]
    if not enemy.isDestroyed then
      if boxes_colliding(laser, enemy) then
        enemy.isDestroyed = true
      end
    end
  end
end

-- ===== HELPER FUNCTIONS =====

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

function boxes_colliding(box1, box2)
  local box1_left = box1.x - box1.width / 2
  local box1_right = box1.x + box1.width / 2
  local box1_bottom = box1.y - box1.height / 2
  local box1_top = box1.y + box1.height / 2

  local box2_left = box2.x - box2.width / 2
  local box2_right = box2.x + box2.width / 2
  local box2_bottom = box2.y - box2.height / 2
  local box2_top = box2.y + box2.height / 2

  if box1_right > box2_left and
     box1_left < box2_right and
     box1_top > box2_bottom and
     box1_bottom < box2_top then
    return true
  end

  return false
end

function init_eyes()
  eye_rotation = 0

  left_eye = create_box(0, 0, 28, 28, 0.7, 0.57575, "#FF00FF")
  left_eye.isDestroyed = false

  right_eye = create_box(0, 0, 28, 28, -0.6, 0.37575, "#00FFFF")
  right_eye.isDestroyed = false
end

function update_eyes()
  eye_rotation = eye_rotation + 12

  if not left_eye.isDestroyed then
    left_eye.x = left_eye.x + left_eye.vx
    left_eye.y = left_eye.y + left_eye.vy

    if left_eye.x < -100 then left_eye.vx = 0.7 end
    if left_eye.x > 100 then left_eye.vx = -0.7 end
    if left_eye.y < -100 then left_eye.vy = 0.57575 end
    if left_eye.y > 100 then left_eye.vy = -0.57575 end
  end

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
  if not left_eye.isDestroyed then
    draw_box(left_eye)
    screen:setDrawScale(1, 1)
    screen:setDrawRotation(eye_rotation)
    screen:drawSprite("googlya", left_eye.x, left_eye.y, 32, 32)
  end

  if not right_eye.isDestroyed then
    screen:setDrawRotation(-eye_rotation)
    screen:drawSprite("googlyb", right_eye.x, right_eye.y, 32, 32)
  end

  screen:setDrawRotation(0)
end
