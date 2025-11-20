-- ============================================
-- SOLUTION FOR STEP 6: AUTO-SPAWN AFTER ALL ENEMIES DESTROYED
-- ============================================
-- Added auto-spawn check to update_enemies() for continuous gameplay

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

-- ===== NEW RANDOM ENEMY FUNCTION =====

function random_enemy()
  local enemy = create_enemy("enemy_ship", 32, 32)

  -- Random position anywhere on screen
  enemy.x = (math.random() - 0.5) * 200
  enemy.y = (math.random() - 0.5) * 200

  -- Random velocity
  enemy.vx = (math.random() - 0.5) * 2
  enemy.vy = (math.random() - 0.5) * 2

  return enemy
end

-- ===== STEP 2B: ENHANCED SPAWN_ENEMY() WITH RANDOMIZATION =====

-- Global tables for randomization options
SIZES = {16, 24, 32, 40, 48}
ENEMY_SPRITES = {"enemyblack1", "enemyblue2", "enemygreen3", "enemyred4", "ufoblue"}

-- ===== STEP 4: SPAWN_ENEMY() WITH OBJECT POOLING =====

function spawn_enemy()
  -- OBJECT POOLING: Try to find a destroyed enemy to reuse
  local enemy = nil

  for ix, e in pairs(enemies) do
    if e.isDestroyed then
      enemy = e
      break  -- Found one! Stop searching
    end
  end

  -- Generate random properties
  local size = SIZES[math.random(1, 5)]
  local sprite_name = ENEMY_SPRITES[math.random(1, 5)]

  -- If no destroyed enemy found, create a new one
  if enemy == nil then
    enemy = create_enemy(sprite_name, size, size)
  end

  -- Set/reset properties (works for both new and reused enemies)
  enemy.sprite = sprite_name
  enemy.width = size
  enemy.height = size
  enemy.x = math.random(-100, 100)
  enemy.y = 100
  enemy.vx = math.random(-10, 10) / 10
  enemy.vy = -1
  enemy.isDestroyed = false
end

-- ===== STEP 3: REFACTORED INIT_ENEMIES() =====

function init_enemies()
  enemies = {}

  -- Spawn 1 enemy at the start
  spawn_enemy()
end

-- ===== STEP 5: ALL_ENEMIES_DESTROYED() FUNCTION =====

function all_enemies_destroyed()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      return false  -- Found a living enemy - not all destroyed!
    end
  end
  return true  -- Made it through the loop - all destroyed!
end

-- ===== REFACTORED WITH LOOP AND ROTATION =====

function draw_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      screen:setDrawRotation(0)
      draw_box(enemy)
      screen:setDrawRotation(enemy.rotation)
      screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
    end
  end
  screen:setDrawRotation(0)
end

-- ===== STEP 6: UPDATE_ENEMIES() WITH AUTO-SPAWN =====

function update_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      enemy.x = enemy.x + enemy.vx
      enemy.y = enemy.y + enemy.vy

      enemy.rotation = enemy.rotation + enemy.rotation_speed

      if enemy.x < -100 then enemy.vx = -enemy.vx end
      if enemy.x > 100 then enemy.vx = -enemy.vx end
      if enemy.y < -100 then enemy.vy = -enemy.vy end
      if enemy.y > 100 then enemy.vy = -enemy.vy end
    end
  end

  -- NEW: Check if all enemies are destroyed
  if all_enemies_destroyed() then
    spawn_enemy()  -- Spawn one new enemy
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

-- ===== REFACTORED WITH NESTED LOOP =====

function check_collisions()
  for ix, laser in pairs(lasers) do

    -- Check collisions with ALL enemies using a loop
    for jx, enemy in pairs(enemies) do
      if not enemy.isDestroyed then
        if boxes_colliding(laser, enemy) then
          enemy.isDestroyed = true
        end
      end
    end
  end
end


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

init = function()
  init_stars()
  init_player()
  init_enemies()
  init_lasers()
end

update = function()
  update_stars()
  update_player()
  update_enemies()
  move_lasers()
  fire_laser()
  check_collisions()
end

draw = function()
  screen:clear("rgb(0, 0, 20)")

  draw_stars()
  draw_enemies()
  draw_player()
  draw_lasers()
end
