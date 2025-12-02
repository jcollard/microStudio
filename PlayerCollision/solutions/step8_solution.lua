-- ============================================
-- SOLUTION FOR STEP 8: RESTART FROM GAME OVER (FINAL)
-- ============================================
-- Added show_title_screen(), wired up game over restart

enemies = {}

RESPAWN_DELAY = 120
lives = 3
game_state = "title"

function create_enemy(sprite_name, width, height)
  local enemy = create_box(0, 0, width, height, 0, 0, "#FF0000")
  enemy.sprite = sprite_name
  enemy.rotation = 0
  enemy.rotation_speed = 0
  enemy.isDestroyed = false
  table.insert(enemies, enemy)
  return enemy
end

SIZES = {16, 24, 32, 40, 48}
ENEMY_SPRITES = {"enemyblack1", "enemyblue2", "enemygreen3", "enemyred4", "ufoblue"}

function spawn_enemy()
  local enemy = nil

  for ix, e in pairs(enemies) do
    if e.isDestroyed then
      enemy = e
      break
    end
  end

  local size = SIZES[math.random(1, 5)]
  local sprite_name = ENEMY_SPRITES[math.random(1, 5)]

  if enemy == nil then
    enemy = create_enemy(sprite_name, size, size)
  end

  enemy.sprite = sprite_name
  enemy.width = size
  enemy.height = size
  enemy.x = math.random(-100, 100)
  enemy.y = 100
  enemy.vx = math.random(-10, 10) / 10
  enemy.vy = -1
  enemy.isDestroyed = false
end

function spawn_enemy_wave()
  for i = 1, #enemies do
    spawn_enemy()
  end
  spawn_enemy()
end

function init_enemies()
  enemies = {}
  spawn_enemy()
end

function all_enemies_destroyed()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      return false
    end
  end
  return true
end

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

  if all_enemies_destroyed() then
    spawn_enemy_wave()
  end
end

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

function player_hit()
  player.isDestroyed = true
  player.respawn_timer = 0
  lives = lives - 1
end

function check_collisions()
  for ix, laser in pairs(lasers) do
    for jx, enemy in pairs(enemies) do
      if not enemy.isDestroyed then
        if boxes_colliding(laser, enemy) then
          enemy.isDestroyed = true
        end
      end
    end
  end

  if player.isDestroyed then
    return
  end

  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      if boxes_colliding(player, enemy) then
        player_hit()
        enemy.isDestroyed = true
        return
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
  player.isDestroyed = false
  player.respawn_timer = 0
  rotation = 0
end

function respawn_player()
  player.isDestroyed = false
  player.x = 0
  player.y = -80
  player.respawn_timer = 0
end

function init_game()
  game_state = "playing"
  lives = 3

  -- Reset player
  player.isDestroyed = false
  player.x = 0
  player.y = -80
  player.respawn_timer = 0

  -- Clear and respawn enemies
  enemies = {}
  spawn_enemy()

  -- Clear lasers
  lasers = {}
end

-- ===== STEP 8: NEW show_title_screen() =====

function show_title_screen()
  game_state = "title"
  player.isDestroyed = true
  player.respawn_timer = 0

  -- Clear all enemies
  for ix, enemy in pairs(enemies) do
    enemy.isDestroyed = true
  end

  -- Clear all lasers (move them off screen)
  for ix, laser in pairs(lasers) do
    laser.y = 500  -- Move off screen so they get recycled
  end
end

-- ===== STEP 8: UPDATED update_respawn() =====

function update_respawn()
  player.respawn_timer = player.respawn_timer + 1

  if player.respawn_timer >= RESPAWN_DELAY then
    if keyboard.press.ENTER == 1 then
      if lives <= 0 then
        show_title_screen()  -- NEW: Go to title on game over
      else
        respawn_player()
      end
    end
  end
end

function update_player()
  if player.isDestroyed then
    update_respawn()
    return
  end

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
  if player.isDestroyed then
    return
  end

  screen:setDrawRotation(0)
  draw_box(player)
  screen:setDrawRotation(rotation)
  screen:drawSprite("player", player.x, player.y, 99*0.25, 75*0.25)
  screen:setDrawRotation(0)
end

function draw_ui()
  -- Title screen
  if game_state == "title" then
    screen:drawText("SPACE FLYER", 0, 30, 50, "#FFFFFF")
    screen:drawText("Press Enter to Take Flight!", 0, -20, 18, "#AAAAAA")
    return
  end

  -- Playing state UI
  -- Lives display (always visible during gameplay)
  screen:drawText("Ships: " .. lives, 0, screen.height / 2 - 10, 15, "#FFFFFF")

  -- Respawn or Game Over message
  if player.isDestroyed then
    if player.respawn_timer >= RESPAWN_DELAY then
      if lives <= 0 then
        -- Game Over screen
        screen:drawText("GAME OVER", 0, 20, 40, "#FF0000")
        screen:drawText("Press Enter to Continue", 0, -20, 15, "#FFFFFF")
      else
        -- Respawn prompt
        screen:drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
      end
    end
  end
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
  if player.isDestroyed then
    return
  end

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
  init_lasers()
  enemies = {}

  game_state = "title"
  player.isDestroyed = true
end

update = function()
  update_stars()

  if game_state == "title" then
    if keyboard.press.ENTER == 1 then
      init_game()
    end
    return
  end

  update_player()
  update_enemies()
  move_lasers()
  fire_laser()
  check_collisions()
end

draw = function()
  screen:clear("rgb(0, 0, 20)")
  draw_stars()

  if game_state == "playing" then
    draw_enemies()
    draw_player()
    draw_lasers()
  end

  draw_ui()
end
