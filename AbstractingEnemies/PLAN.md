# Abstracting Enemies - Challenge Plan

## Overview
**Goal**: Refactor hardcoded individual enemies into a scalable, data-driven enemy system.

**Key Concept**: Instead of writing separate `init_eyes()`, `update_eyes()`, and `draw_eyes()` functions, students will create a single `init_enemies()`, `update_enemies()`, and `draw_enemies()` system that can handle ANY number of enemies.

**Starting Point**: `DestroyingEnemies/solutions/step8_solution.lua`

---

## Learning Progression

### Step 0: Welcome - The Hardcoding Problem
- Explain the current system: hardcoded `left_eye` and `right_eye` with individual logic
- Show the problem: adding a 3rd eye means more code, more duplication, more bugs
- Introduce the solution: **Create an enemies table and loop through it**
- Show the benefits: add 100 enemies with the same code!
- Preview what they'll build

### Step 1: Create create_enemy() Function
**New Concept**: A factory function for creating enemies with sensible defaults

**Starting code**:
- `create_box()` already exists
- `create_laser()` exists as a pattern

**Task**: Create a `create_enemy()` function that:
- Takes REQUIRED parameters: `(sprite_name, width, height)`
- Uses DEFAULT values: `x=0, y=0, vx=0, vy=0, color="#FF0000", rotation=0, rotation_speed=0`
- Uses `create_box()` internally (reuse!)
- Adds new properties:
  - `sprite` - to store the sprite name
  - `rotation` - current rotation angle (default 0)
  - `rotation_speed` - how fast to rotate (default 0, can be set per enemy)
  - `isDestroyed` - false by default
- **AUTOMATICALLY adds the enemy to the `enemies` table** using `table.insert()`
- Returns the enemy object

**Code changes**:
```lua
function create_enemy(sprite_name, width, height)
  local enemy = create_box(0, 0, width, height, 0, 0, "#FF0000")
  enemy.sprite = sprite_name
  enemy.rotation = 0
  enemy.rotation_speed = 0
  enemy.isDestroyed = false
  table.insert(enemies, enemy)  -- Automatically added to table!
  return enemy
end
```

**Usage pattern**:
```lua
local enemy = create_enemy("enemy_ship", 32, 32)
enemy.x = 50       -- Customize after creation
enemy.y = 50
enemy.vx = 0.5
enemy.vy = 0.3
-- The enemy is already in the enemies table!
```

**Key teaching moment**: Objects are created with defaults, then customized by setting properties. This mirrors real game development!

**Also**: Create an empty `enemies` table initialization

### Step 2: Create init_enemies() with One Enemy
**New Concept**: Initialize enemies in a table instead of individual variables

**Task**: Create `init_enemies()` that:
- Creates an `enemies = {}` table
- Uses `create_enemy()` to create ONE enemy (the enemy_ship sprite)
- Customizes the enemy's position and velocity by setting properties
- The enemy is automatically added to the `enemies` table by `create_enemy()`!

**Code changes**:
```lua
function init_enemies()
  enemies = {}

  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = 50
  enemy.y = 50
  enemy.vx = 0.5
  enemy.vy = 0.3
  -- create_enemy() already added it to the table!
end
```

**Also update** `init()` to call `init_enemies()` instead of `init_eyes()`

### Step 3: Create draw_enemies() for One Enemy
**New Concept**: Draw enemies from the table

**Task**: Create `draw_enemies()` that:
- Gets the first enemy from the `enemies` table by index
- Draws the bounding box using `draw_box()`
- Draws the sprite using `enemy.sprite` and the enemy's position

**Code changes**:
```lua
function draw_enemies()
  local enemy = enemies[1]
  draw_box(enemy)
  screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
end
```

**Also**:
- Comment out or remove `draw_eyes()` call in `draw()`
- Add `draw_enemies()` call in `draw()`

### Step 4: Create update_enemies() for One Enemy
**New Concept**: Update enemies from the table (but still just one for now)

**Task**: Create `update_enemies()` that:
- Gets the first enemy from the `enemies` table by index
- Updates position and checks boundaries
- Only updates if enemy is NOT destroyed

**Code changes**:
```lua
function update_enemies()
  local enemy = enemies[1]
  if not enemy.isDestroyed then
    enemy.x = enemy.x + enemy.vx
    enemy.y = enemy.y + enemy.vy

    -- Boundary checks
    if enemy.x < -100 then enemy.vx = -enemy.vx end
    if enemy.x > 100 then enemy.vx = -enemy.vx end
    if enemy.y < -100 then enemy.vy = -enemy.vy end
    if enemy.y > 100 then enemy.vy = -enemy.vy end
  end
end
```

**Also**:
- Comment out or remove `update_eyes()` call in `update()`
- Add `update_enemies()` call in `update()`
- Comment out or remove `init_eyes()` call in `init()`
- Test with ONE enemy bouncing around

### Step 5: Add a Second Enemy
**New Concept**: Managing multiple enemies by indexing

**Guided Step**: Update `init_enemies()` to create TWO enemies, and update `update_enemies()` and `draw_enemies()` to handle both

**Code changes**:

Update `init_enemies()` to create TWO enemies:
```lua
function init_enemies()
  enemies = {}

  local enemy1 = create_enemy("enemy_ship", 32, 32)
  enemy1.x = 50
  enemy1.y = 50
  enemy1.vx = 0.5
  enemy1.vy = 0.3

  local enemy2 = create_enemy("enemy_ship", 32, 32)
  enemy2.x = -50
  enemy2.y = -50
  enemy2.vx = -0.4
  enemy2.vy = -0.4
end
```

Update `update_enemies()` to handle BOTH enemies:
```lua
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

  -- NEW: Also handle the second enemy
  enemy = enemies[2]
  if not enemy.isDestroyed then
    enemy.x = enemy.x + enemy.vx
    enemy.y = enemy.y + enemy.vy
    if enemy.x < -100 then enemy.vx = -enemy.vx end
    if enemy.x > 100 then enemy.vx = -enemy.vx end
    if enemy.y < -100 then enemy.vy = -enemy.vy end
    if enemy.y > 100 then enemy.vy = -enemy.vy end
  end
end
```

Update `draw_enemies()` to handle BOTH enemies:
```lua
function draw_enemies()
  local enemy = enemies[1]
  draw_box(enemy)
  screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)

  -- NEW: Also draw the second enemy
  enemy = enemies[2]
  draw_box(enemy)
  screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
end
```

**Key insight**: We're seeing repetition! This is where a loop becomes handy. Next step will introduce loops to eliminate this duplication.

### Step 6: Refactor with Loops - From Duplication to Elegance
**New Concept**: Loops eliminate copy-paste code

**Teaching moment**: When you see the same code repeated with only one thing changing (the index: 1, 2, 3...), that's a perfect opportunity for a loop!

**Guided Step**: Refactor `update_enemies()` to use a loop

**Show the problem**:
```lua
-- This code is IDENTICAL except for the enemy index - repetition!
function update_enemies()
  local enemy = enemies[1]
  if not enemy.isDestroyed then
    enemy.x = enemy.x + enemy.vx
    -- ... more code
  end

  -- EXACT SAME CODE - just change [1] to [2]
  enemy = enemies[2]
  if not enemy.isDestroyed then
    enemy.x = enemy.x + enemy.vx
    -- ... more code
  end
end
```

**Teach the pattern**:
- **What repeats**: The entire update block
- **What changes**: The index (1, 2, 3...)
- **The solution**: Use a loop to iterate through indices!

**Solution with loop** (replace entire `update_enemies()`):
```lua
function update_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      enemy.x = enemy.x + enemy.vx
      enemy.y = enemy.y + enemy.vy

      -- Boundary checks
      if enemy.x < -100 then enemy.vx = -enemy.vx end
      if enemy.x > 100 then enemy.vx = -enemy.vx end
      if enemy.y < -100 then enemy.vy = -enemy.vy end
      if enemy.y > 100 then enemy.vy = -enemy.vy end
    end
  end
end
```

**How it works**:
- `for ix, enemy in pairs(enemies)` - Loop through EVERY enemy in the table
- `ix` - The index (1, 2, 3...)
- `enemy` - The actual enemy object
- The code runs once per enemy automatically!

**Challenge Step**: Now YOU refactor `draw_enemies()` to use a loop

Students must convert their current `draw_enemies()` (which manually handles `enemies[1]` and `enemies[2]`) to use the same loop pattern.

**Testing**: With ONE line of loop code:
- Add 3 enemies and they all update and draw
- Add 10 enemies and they all work
- The power of abstraction!

### Step 7: Migrate the Eyes to the Enemy System
**Challenge Step**: Replace the old eye system with the new enemy system

**Task**:
- Add the left eye and right eye to `init_enemies()` using `create_enemy()`
- Remove calls to `init_eyes()`, `update_eyes()`, `draw_eyes()`
- Keep the eye rotation logic (move to `update_enemies()`)

**Code changes** (in `init_enemies()`):
```lua
function init_enemies()
  enemies = {}
  eye_rotation = 0  -- Move eye rotation here

  -- Add the original eyes as enemies
  local left_eye = create_enemy("googlya", 28, 28)
  left_eye.x = 0
  left_eye.y = 0
  left_eye.vx = 0.7
  left_eye.vy = 0.57575
  left_eye.color = "#FF00FF"

  local right_eye = create_enemy("googlyb", 28, 28)
  right_eye.x = 0
  right_eye.y = 0
  right_eye.vx = -0.6
  right_eye.vy = 0.37575
  right_eye.color = "#00FFFF"

  -- Add the other enemies too
  local enemy1 = create_enemy("enemy_ship", 32, 32)
  enemy1.x = 50
  enemy1.y = 50
  enemy1.vx = 0.5
  enemy1.vy = 0.3
  enemy1.color = "#FF6B35"

  local enemy2 = create_enemy("enemy_ship", 32, 32)
  enemy2.x = -50
  enemy2.y = -50
  enemy2.vx = -0.4
  enemy2.vy = -0.4
  enemy2.color = "#00D9FF"
end
```

**Update** `update_enemies()` to handle eye rotation:
```lua
function update_enemies()
  eye_rotation = eye_rotation + 12  -- Keep this

  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      enemy.x = enemy.x + enemy.vx
      enemy.y = enemy.y + enemy.vy

      -- Boundary checks
      if enemy.x < -100 then enemy.vx = -enemy.vx end
      if enemy.x > 100 then enemy.vx = -enemy.vx end
      if enemy.y < -100 then enemy.vy = -enemy.vy end
      if enemy.y > 100 then enemy.vy = -enemy.vy end
    end
  end
end
```

**Update** `draw_enemies()` to handle eye sprites with rotation:
```lua
function draw_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      draw_box(enemy)

      -- Special handling for eye sprites
      if enemy.sprite == "googlya" then
        screen:setDrawScale(1, 1)
        screen:setDrawRotation(eye_rotation)
        screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
        screen:setDrawRotation(0)
      elseif enemy.sprite == "googlyb" then
        screen:setDrawRotation(-eye_rotation)
        screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
        screen:setDrawRotation(0)
      else
        -- Regular enemy sprites (no rotation)
        screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
      end
    end
  end
end
```

**Remove** the old `init_eyes()`, `update_eyes()`, `draw_eyes()` functions entirely

### Step 8: The Power of Abstraction
**Celebration Step**: Show how easy it is to add more enemies now

**Guided**: Add 5 new enemies in `init_enemies()` without changing any other code
- `update_enemies()` still works
- `draw_enemies()` still works
- Collision detection still works

**Code change** (just add to `init_enemies()`):
```lua
-- Add lots more enemies - the loop handles them all!
for i = 1, 5 do
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 150
  enemy.y = (math.random() - 0.5) * 150
  enemy.vx = (math.random() - 0.5) * 0.5
  enemy.vy = (math.random() - 0.5) * 0.5
  enemy.color = "#FF6B35"
  -- create_enemy() already added it!
end
```

### Step 9: Congratulations
- Recap what they learned
- Show how abstraction makes code more powerful
- Mention: this is how real game engines work
- Challenge ideas for extensions

---

## Summary

| Step | Focus | Code Changes |
|------|-------|--------------|
| 0 | Introduction | None |
| 1 | `create_enemy()` function | New function |
| 2 | `init_enemies()` with 1 enemy | New function, update `init()` |
| 3 | `draw_enemies()` for one enemy | New function, update `draw()` (using indexing) |
| 4 | `update_enemies()` for one enemy | New function, update `update()` (using indexing) |
| 5 | Add 2nd enemy | Expand all functions (shows duplication problem) |
| 6 | **Refactor with loops** | Convert duplication to loops (guided + challenge) |
| 7 | Replace eyes with enemy system | Major refactor, remove old functions |
| 8 | Add many enemies | Show the power with loop |
| 9 | Celebration | None |

---

## Key Teaching Points

1. **Abstraction**: Generic functions replace specific ones
2. **Factory pattern**: `create_enemy()` creates objects with sensible defaults
3. **Table-driven design**: Data (the enemies table) drives behavior
4. **Loops eliminate duplication**: Recognize repetition and convert to loops
5. **DRY principle**: Don't repeat yourself - one loop handles all enemies
6. **Scalability**: Adding enemies becomes trivial (works with any number)
7. **Refactoring**: Improve code without changing functionality

