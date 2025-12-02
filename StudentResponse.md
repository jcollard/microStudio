# Code Review: AbstractingEnemy Challenge

## Issues Found

### 1. Multiple `init_enemies()` Definitions
You have **three different `init_enemies()` functions** defined in your code (lines 14, 25, and 39). In Lua, when you define the same function multiple times, only the **last one** is actually used. The first two are completely ignored!

**Solution:** Delete the first two definitions and keep only the final one (starting at line 39).

---

### 2. Missing `end` Statement
The second `init_enemies()` function (line 25) is missing its closing `end` statement. This causes the code structure to be broken.

**Solution:** When you remove the duplicate functions, this issue will be resolved.

---

### 3. Incomplete `check_collisions()` Function
Your collision detection function (line 98) has several problems:

```lua
function check_collisions()
  -- Check each laser
  for jx, laser in pairs(lasers) do
    -- Check left eye if not already destroyed
    if not enemy.isDestroyed then
      boxes_colliding(laser, enemy)
    end
  end
end
```

**Problems:**
- You loop through `lasers` but NOT through `enemies`
- You reference a variable `enemy` that doesn't exist in this scope
- You call `boxes_colliding()` but don't use the result
- When a collision happens, nothing occurs (no explosion, no score, etc.)

**Solution:** You need to use nested loops - one for lasers, one for enemies:

```lua
function check_collisions()
  for jx, laser in pairs(lasers) do
    for ex, enemy in pairs(enemies) do
      if not enemy.isDestroyed then
        if boxes_colliding(laser, enemy) then
          enemy.isDestroyed = true
          -- Add any other effects here (score, explosion, etc.)
        end
      end
    end
  end
end
```

---

### 4. Missing Required Functions
Your `update()` and `draw()` functions call:
- `update_enemies()` (line 256)
- `draw_enemies()` (line 262)

But these functions are **never defined** in your code! This will cause a runtime error.

**Solution:** You need to create these functions:

```lua
function update_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      enemy.x = enemy.x + enemy.vx
      enemy.y = enemy.y + enemy.vy
      enemy.rotation = enemy.rotation + enemy.rotation_speed
      -- Add boundary checking here
    end
  end
end

function draw_enemies()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      screen:setDrawRotation(enemy.rotation)
      screen:drawSprite(enemy.sprite, enemy.x, enemy.y, enemy.width, enemy.height)
      screen:setDrawRotation(0)
    end
  end
end
```

---

### 5. Typo in Property Name
On line 72, you wrote `isDistroyed` instead of `isDestroyed` (you're missing the "e" in "Destroyed").

**Solution:** Change line 72 from:
```lua
enemy.isDistroyed = false
```
to:
```lua
enemy.isDestroyed = false
```

---

### 6. Extra `end` Statement
Line 266 has an extra `end` that doesn't belong there. The `draw()` function should end at line 265.

**Solution:** Delete line 266.

---

## Summary Checklist

To fix your code:
- [ ] Remove the duplicate `init_enemies()` functions (keep only the one at line 39)
- [ ] Fix the `check_collisions()` function to loop through both lasers AND enemies
- [ ] Make `check_collisions()` actually mark enemies as destroyed when hit
- [ ] Create the missing `update_enemies()` function
- [ ] Create the missing `draw_enemies()` function
- [ ] Fix the typo: `isDistroyed` → `isDestroyed`
- [ ] Remove the extra `end` statement at line 266

Once you fix these issues, your enemy system should work properly! Good luck!
