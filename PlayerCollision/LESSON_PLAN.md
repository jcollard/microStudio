# Player Collision - Lesson Plan

## Overview

In this lesson, students will implement a complete game loop by adding collision detection, health/lives systems, and game states. Students will apply patterns learned in previous lessons (like the `isDestroyed` flag) to the player object, creating a fully playable game with title screen, gameplay, and game over states.

## Prerequisites

- Completed **Enemy Spawner** lesson
- Working wave-based enemy spawning system
- Player movement and laser firing mechanics
- Understanding of `isDestroyed` pattern from enemies

## Learning Objectives

By the end of this lesson, students will be able to:
- Implement player-enemy collision detection
- Apply the `isDestroyed` pattern to the player
- Create a lives/health system with UI display
- Manage game states (title, playing, game over)
- Build a complete game loop with restart functionality

---

## Step 0: Welcome

**Purpose:** Introduce the lesson goals and show the finished product.

**Content:**
- Explain that we're building a complete game loop
- Show demo of finished game with:
  - Title screen
  - Gameplay with collision and lives
  - Game over screen
  - Restart functionality
- Highlight that students will apply familiar patterns (like `isDestroyed`) to new contexts

**Key Concepts:**
- Game states (title, playing, game over)
- Collision detection
- Lives/health systems
- Complete game loop

---

## Step 1: Getting Started

**Purpose:** Ensure students have the correct starting project.

**Content:**
- Option 1: Clone starter project (link to finished Enemy Spawner)
- Option 2: Continue from their own project

**Requirements Checklist:**
- Working wave-based enemy spawning
- Player object with `x`, `y`, `width`, `height` properties
- `fire_laser()` function for shooting
- `check_collisions()` function that detects laser-enemy collisions
- `update_player()` and `draw_player()` functions

**Starter Code Reference:**
- Show the existing `check_collisions()` function (laser vs enemy)
- Show the existing player properties
- Show the existing `fire_laser()` function

---

## Step 2: Detecting Collision on the Player

**Purpose:** Add player-enemy collision detection.

**Task:**
Update `check_collisions()` to also check if any enemy is colliding with the player.

**Implementation:**
```lua
function check_collisions()
  -- Existing laser-enemy collision code...

  -- NEW: Check if any enemy is colliding with the player
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      if check_collision(player, enemy) then
        player.isDestroyed = true
        enemy.isDestroyed = true  -- Optional: destroy the enemy too
      end
    end
  end
end
```

**Key Concepts:**
- Reusing existing collision detection logic
- Applying `isDestroyed` pattern to the player
- The player needs `isDestroyed` property initialized to `false`

**Testing:**
- Run the game and let an enemy touch the player
- The player should "disappear" (we'll handle visuals next)

---

## Step 2b: Disable Player When Destroyed

**Purpose:** Stop updating and drawing the player when destroyed.

**Task:**
Update `update_player()` and `draw_player()` to check `isDestroyed` before processing.

**Implementation:**
```lua
function update_player()
  if player.isDestroyed then
    return  -- Don't process input if destroyed
  end

  -- Existing movement code...
end

function draw_player()
  if player.isDestroyed then
    return  -- Don't draw if destroyed
  end

  -- Existing draw code...
end
```

**Key Concepts:**
- Early return pattern
- Same pattern used for enemies now applied to player
- Separation of concerns (update vs draw)

**Testing:**
- When hit, player should stop moving and disappear from screen
- Movement keys should have no effect

---

## Step 2c: Prevent Firing When Destroyed

**Purpose:** Stop the player from firing lasers when destroyed.

**Task:**
Update `fire_laser()` to check if player is destroyed before creating a laser.

**Implementation:**
```lua
function fire_laser()
  if player.isDestroyed then
    return  -- Can't fire if destroyed
  end

  -- Existing laser creation code...
end
```

**Key Concepts:**
- Consistent state checking across all player actions
- Defensive programming

**Testing:**
- After being destroyed, pressing space should not create lasers

---

## Step 3: Respawning the Player

**Purpose:** Allow the player to respawn after being destroyed.

**Task:**
1. Display "Press Enter to Respawn" message after a 2-second delay
2. When Enter is pressed, reset the player

**New Variables:**
```lua
player.respawn_timer = 0
RESPAWN_DELAY = 120  -- 2 seconds at 60 FPS
```

**Implementation - Update:**
```lua
function update_player()
  if player.isDestroyed then
    player.respawn_timer = player.respawn_timer + 1

    if player.respawn_timer >= RESPAWN_DELAY then
      if keyboard.ENTER then
        respawn_player()
      end
    end
    return
  end

  -- Existing movement code...
end

function respawn_player()
  player.isDestroyed = false
  player.x = 0
  player.y = -80
  player.respawn_timer = 0
end
```

**Implementation - Draw:**
```lua
function draw_player()
  if player.isDestroyed then
    if player.respawn_timer >= RESPAWN_DELAY then
      screen.drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
    end
    return
  end

  -- Existing draw code...
end
```

**Key Concepts:**
- Timer-based delays using frame counting
- State transitions
- Centralizing respawn logic in a function

**Testing:**
- Get destroyed, wait 2 seconds, see message
- Press Enter, player should reappear at bottom center

---

## Step 4: Adding a Life Count

**Purpose:** Give the player multiple chances with a lives system.

**Task:**
1. Create a `lives` variable starting at 3
2. Display lives count on screen
3. Reduce lives when destroyed

**New Variables:**
```lua
lives = 3
```

**Implementation:**
```lua
-- In check_collisions(), when player is hit:
if check_collision(player, enemy) then
  player.isDestroyed = true
  lives = lives - 1
  enemy.isDestroyed = true
end

-- In draw() or draw_ui():
function draw_ui()
  screen.drawText("Ships: " .. lives, -90, -90, 15, "#FFFFFF")
end
```

**Key Concepts:**
- Global game state variables
- String concatenation for UI
- UI positioning (bottom-left corner)

**Testing:**
- Lives should decrease each time player is hit
- Display should update immediately

---

## Step 5: Game Over Screen

**Purpose:** End the game when all lives are lost.

**Task:**
When destroyed and `lives <= 0`, show "Game Over" instead of respawn prompt.

**Implementation:**
```lua
function draw_player()
  if player.isDestroyed then
    if lives <= 0 then
      -- Game Over screen
      screen.drawText("GAME OVER", 0, 20, 40, "#FF0000")
      screen.drawText("Press Enter to Continue", 0, -20, 15, "#FFFFFF")
    else
      -- Respawn prompt (existing code)
      if player.respawn_timer >= RESPAWN_DELAY then
        screen.drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
      end
    end
    return
  end

  -- Existing draw code...
end
```

**Update respawn logic:**
```lua
function update_player()
  if player.isDestroyed then
    player.respawn_timer = player.respawn_timer + 1

    if player.respawn_timer >= RESPAWN_DELAY then
      if keyboard.ENTER then
        if lives <= 0 then
          -- Go to title screen (implemented in Step 7)
          show_title_screen()
        else
          respawn_player()
        end
      end
    end
    return
  end

  -- Existing movement code...
end
```

**Key Concepts:**
- Conditional UI based on game state
- Branching game flow

**Testing:**
- Lose all 3 lives
- Should see "GAME OVER" instead of respawn message

---

## Step 6: Adding a Title Screen

**Purpose:** Create a proper game start experience.

**Task:**
1. Start the game on a title screen (player is `isDestroyed = true`)
2. Display game title and start instructions
3. Pressing Enter initializes and starts the game

**New Variables:**
```lua
game_state = "title"  -- "title", "playing", "gameover"
```

**Implementation:**
```lua
function init()
  game_state = "title"
  player.isDestroyed = true
  enemies = {}
end

function init_game()
  game_state = "playing"
  lives = 3
  player.isDestroyed = false
  player.x = 0
  player.y = -80
  enemies = {}
  spawn_enemy()  -- Start first wave
end

function update()
  if game_state == "title" then
    if keyboard.ENTER then
      init_game()
    end
    return
  end

  -- Existing update code for "playing" state...
  update_player()
  update_enemies()
  update_lasers()
  check_collisions()
end

function draw()
  screen.clear()

  if game_state == "title" then
    screen.drawText("SPACE FLYER", 0, 30, 50, "#FFFFFF")
    screen.drawText("Press Enter to Take Flight!", 0, -20, 18, "#AAAAAA")
    return
  end

  -- Existing draw code for "playing" state...
  draw_enemies()
  draw_player()
  draw_lasers()
  draw_ui()
end
```

**Key Concepts:**
- Game state management
- Initialization functions
- Separating game setup from main loop

**Testing:**
- Game should start on title screen
- Pressing Enter should start gameplay with 3 lives

---

## Step 7: Restart from Game Over

**Purpose:** Allow returning to title screen after game over.

**Task:**
When pressing Enter on game over, return to title screen and clear enemies.

**Implementation:**
```lua
function show_title_screen()
  game_state = "title"
  player.isDestroyed = true
  player.respawn_timer = 0

  -- Clear all enemies
  for ix, enemy in pairs(enemies) do
    enemy.isDestroyed = true
  end
end
```

**Update the game over Enter press:**
```lua
-- In update_player() when lives <= 0 and Enter pressed:
if lives <= 0 then
  show_title_screen()
else
  respawn_player()
end
```

**Key Concepts:**
- State transitions
- Cleanup/reset patterns
- Complete game loop

**Testing:**
- Lose all lives, press Enter on game over
- Should return to title screen
- All enemies should be cleared
- Pressing Enter should start fresh game with 3 lives

---

## Step 8: Congratulations!

**Purpose:** Celebrate completion and suggest extensions.

**Content:**
- Summarize what was built:
  - Complete game loop (title → playing → game over → title)
  - Collision detection with player
  - Lives system with UI
  - Game state management

**Professional Techniques Learned:**
- **State Machines** - Managing game states (title, playing, game over)
- **Game Loop Pattern** - Complete flow from start to restart
- **UI Systems** - Displaying lives and game messages
- **Initialization Patterns** - Proper game reset and setup

**Extension Ideas:**
- Add invincibility frames after respawning
- Add a score system
- Add sound effects for collisions and game over
- Add a high score that persists between sessions
- Add visual effects when player is destroyed

**Games Using These Techniques:**
- Galaga, Space Invaders (lives system)
- Most arcade games (title → play → game over loop)
- Roguelikes (full restart on death)

---

## Technical Notes

### Existing Functions to Modify
- `check_collisions()` - Add player-enemy collision
- `update_player()` - Add destroyed state handling, respawn timer, game state checks
- `draw_player()` - Add destroyed state handling, respawn/game over messages
- `fire_laser()` - Add destroyed state check
- `init()` - Set up title screen state
- `update()` - Add game state routing
- `draw()` - Add game state routing

### New Functions to Create
- `respawn_player()` - Reset player position and state
- `init_game()` - Initialize a new game session
- `show_title_screen()` - Transition to title screen
- `draw_ui()` - Draw lives counter (may already exist)

### New Variables
- `player.isDestroyed` - Boolean for player destroyed state
- `player.respawn_timer` - Frame counter for respawn delay
- `lives` - Number of remaining lives
- `game_state` - Current game state ("title", "playing", "gameover")
- `RESPAWN_DELAY` - Constant for respawn timer (120 frames = 2 seconds)

---

## Lesson Flow Summary

1. **Step 0**: Overview and demo
2. **Step 1**: Project setup
3. **Step 2-2c**: Collision detection and player destruction
4. **Step 3**: Respawn mechanic
5. **Step 4**: Lives system
6. **Step 5**: Game over screen
7. **Step 6**: Title screen
8. **Step 7**: Complete loop (restart)
9. **Step 8**: Celebration and extensions
