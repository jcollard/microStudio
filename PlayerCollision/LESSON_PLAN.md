# Player Collision - Lesson Plan

## Overview

In this lesson, students will implement a complete game loop by adding player-enemy collision detection, a lives system, and game states. Students will apply patterns learned in previous lessons (like the `isDestroyed` flag) to the player object, creating a fully playable game with title screen, gameplay, and game over states.

## Prerequisites

- Completed **Enemy Spawner** lesson
- Working wave-based enemy spawning system
- Player movement and laser firing mechanics
- Understanding of `isDestroyed` pattern from enemies

## Learning Objectives

By the end of this lesson, students will be able to:
- Extend existing collision detection to include player-enemy collisions
- Apply the `isDestroyed` pattern to the player
- Create a lives system with UI display
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
- Player-enemy collision detection
- Lives system
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
- `boxes_colliding()` function for AABB collision detection
- `check_collisions()` function that detects laser-enemy collisions
- `update_player()` and `draw_player()` functions

**Existing Code Reference:**

Show the existing `boxes_colliding()` function (students wrote this previously):
```lua
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
```

Show the existing `check_collisions()` function:
```lua
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
end
```

---

## Step 2: Add isDestroyed to Player

**Purpose:** Prepare the player object to use the same destruction pattern as enemies.

**Task:**
Update `init_player()` to add the `isDestroyed` property.

**Implementation:**
```diff
 function init_player()
   player = create_box(0, -80, 25, 25, 0, 0, "#00FF00")
+  player.isDestroyed = false  -- NEW: Add destroyed flag
   rotation = 0
 end
```

**Key Concepts:**
- Consistent patterns across game objects
- The player now follows the same convention as enemies

**Testing:**
- In the console, type `player.isDestroyed = true` and observe (nothing happens yet)
- We'll make this do something in the next steps

---

## Step 2b: Disable Player When Destroyed

**Purpose:** Stop updating and drawing the player when destroyed.

**Task:**
Update `update_player()` and `draw_player()` to check `isDestroyed` before processing.

**Implementation - Update update_player:**
```diff
 function update_player()
+  if player.isDestroyed then
+    return  -- Don't process input if destroyed
+  end
+
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
```

**Implementation - Update draw_player:**
```diff
 function draw_player()
+  if player.isDestroyed then
+    return  -- Don't draw if destroyed
+  end
+
   screen:setDrawRotation(0)
   draw_box(player)
   screen:setDrawRotation(rotation)
   screen:drawSprite("player", player.x, player.y, 99*0.25, 75*0.25)
   screen:setDrawRotation(0)
 end
```

**Key Concepts:**
- Early return pattern
- Same pattern used for enemies now applied to player
- Separation of concerns (update vs draw)

**Testing:**
- In the console, type `player.isDestroyed = true`
- Player should disappear and movement keys should have no effect
- Type `player.isDestroyed = false` to bring the player back

---

## Step 2c: Prevent Firing When Destroyed

**Purpose:** Stop the player from firing lasers when destroyed.

**Task:**
Update `fire_laser()` to check if player is destroyed before creating a laser.

**Implementation:**
```diff
 function fire_laser()
+  if player.isDestroyed then
+    return  -- Can't fire if destroyed
+  end
+
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
```

**Key Concepts:**
- Consistent state checking across all player actions
- Defensive programming

**Testing:**
- In the console, type `player.isDestroyed = true`
- Pressing space should not create lasers
- Type `player.isDestroyed = false` to restore normal behavior

---

## Step 3: Detecting Player-Enemy Collision

**Purpose:** Add player-enemy collision detection to trigger destruction automatically.

**Task:**
Update `check_collisions()` to also check if any enemy is colliding with the player.

**Implementation:**
```diff
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
+
+  -- Skip player collision checks if player is already destroyed
+  if player.isDestroyed then
+    return
+  end
+
+  -- NEW: Check if any enemy is colliding with the player
+  for ix, enemy in pairs(enemies) do
+    if not enemy.isDestroyed then
+      if boxes_colliding(player, enemy) then
+        player.isDestroyed = true
+        enemy.isDestroyed = true  -- Destroy the enemy too
+        return  -- Exit early, player is destroyed
+      end
+    end
+  end
 end
```

**Key Concepts:**
- Reusing existing `boxes_colliding()` function
- Applying `isDestroyed` pattern to the player
- Skip collision checks when player is already destroyed
- Early return optimization

**Testing:**
- Run the game and let an enemy touch the player
- The player should disappear (the behavior you tested manually now happens automatically!)

---

## Step 4: Respawning the Player

**Purpose:** Allow the player to respawn after being destroyed.

**Task:**
1. Add a respawn timer that waits 2 seconds before showing the message
2. Display "Press Enter to Respawn" message
3. When Enter is pressed, reset the player

**New Variables (add near top of file or in init):**
```lua
RESPAWN_DELAY = 120  -- 2 seconds at 60 FPS
```

**Implementation - Update init_player:**
```diff
 function init_player()
   player = create_box(0, -80, 25, 25, 0, 0, "#00FF00")
   player.isDestroyed = false
+  player.respawn_timer = 0  -- NEW: Timer for respawn delay
   rotation = 0
 end
```

**Implementation - Create respawn_player function:**
```lua
function respawn_player()
  player.isDestroyed = false
  player.x = 0
  player.y = -80
  player.respawn_timer = 0
end
```

**Implementation - Create update_respawn function:**
```lua
function update_respawn()
  player.respawn_timer = player.respawn_timer + 1

  if player.respawn_timer >= RESPAWN_DELAY then
    if keyboard.press.ENTER then
      respawn_player()
    end
  end
end
```

**Implementation - Update update_player:**
```diff
 function update_player()
   if player.isDestroyed then
+    update_respawn()  -- Handle respawn logic
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
```

**Implementation - Create draw_ui function:**

We'll create a single `draw_ui()` function that handles all text/UI drawing. This keeps all UI code in one place and ensures text is drawn on top of game objects.

```lua
function draw_ui()
  -- Respawn message (only when player is destroyed and timer elapsed)
  if player.isDestroyed then
    if player.respawn_timer >= RESPAWN_DELAY then
      screen:drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
    end
  end
end
```

**Implementation - Update draw function:**

Add `draw_ui()` at the end so text appears on top of everything:

```diff
 draw = function()
   screen:clear("rgb(0, 0, 20)")

   draw_stars()
   draw_enemies()
   draw_player()
   draw_lasers()
+  draw_ui()  -- NEW: Draw all UI text last (on top)
 end
```

**Note:** The `draw_player()` function stays the same as Step 2b - it just returns early when destroyed. All text drawing is handled by `draw_ui()`.

**Key Concepts:**
- Timer-based delays using frame counting (60 FPS = 60 frames per second)
- `keyboard.press.ENTER` detects a single key press (not held)
- State transitions
- Centralizing respawn logic in a function
- **Single UI function** - All text drawing in one place, drawn last

**Testing:**
- Get destroyed, wait 2 seconds, see message
- Press Enter, player should reappear at bottom center

---

## Step 5: Adding a Life Count

**Purpose:** Give the player multiple chances with a lives system.

**Task:**
1. Create a `lives` variable starting at 3
2. Display lives count on screen
3. Reduce lives when destroyed

**New Variable (add near top of file):**
```lua
lives = 3
```

**Implementation - Create player_hit function:**

As our collision code grows, it's important to manage complexity. Extract the "what happens when hit" logic into its own function:

```lua
function player_hit()
  player.isDestroyed = true
  player.respawn_timer = 0
  lives = lives - 1
end
```

**Implementation - Update check_collisions:**
```diff
 -- In check_collisions(), when player is hit:
 if boxes_colliding(player, enemy) then
-  player.isDestroyed = true
+  player_hit()
   enemy.isDestroyed = true
   return
 end
```

**Implementation - Update draw_ui function:**

Extend `draw_ui()` to show the lives counter. The lives display should always be visible during gameplay:

```diff
 function draw_ui()
+  -- Lives display (always visible during gameplay)
+  screen:drawText("Ships: " .. lives, 0, screen.height / 2 - 10, 15, "#FFFFFF")
+
   -- Respawn message (only when player is destroyed and timer elapsed)
   if player.isDestroyed then
     if player.respawn_timer >= RESPAWN_DELAY then
       screen:drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
     end
   end
 end
```

**Key Concepts:**
- Global game state variables
- String concatenation with `..` for UI text
- UI positioning using `screen.height` (text draws from center point in microStudio)
- **Single UI function** - Lives and respawn message both handled in `draw_ui()`

**Testing:**
- Lives should decrease each time player is hit
- Display should update immediately

---

## Step 6: Game Over Screen

**Purpose:** End the game when all lives are lost.

**Task:**
When destroyed and `lives <= 0`, show "Game Over" instead of respawn prompt.

**Implementation - Update draw_ui:**

Update `draw_ui()` to show game over screen when lives run out:

```diff
 function draw_ui()
   -- Lives display (always visible during gameplay)
   screen:drawText("Ships: " .. lives, 0, screen.height / 2 - 10, 15, "#FFFFFF")

-  -- Respawn message (only when player is destroyed and timer elapsed)
+  -- Respawn or Game Over message
   if player.isDestroyed then
     if player.respawn_timer >= RESPAWN_DELAY then
-      screen:drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
+      if lives <= 0 then
+        -- Game Over screen
+        screen:drawText("GAME OVER", 0, 20, 40, "#FF0000")
+        screen:drawText("Press Enter to Continue", 0, -20, 15, "#FFFFFF")
+      else
+        -- Respawn prompt
+        screen:drawText("Press Enter to Respawn", 0, 0, 20, "#FFFFFF")
+      end
     end
   end
 end
```

**Implementation - Update update_respawn:**

Update `update_respawn()` to only allow respawn when lives remain. When game over, pressing Enter does nothing yet (we'll wire this up in Step 8):

```diff
 function update_respawn()
   player.respawn_timer = player.respawn_timer + 1

   if player.respawn_timer >= RESPAWN_DELAY then
-    if keyboard.press.ENTER then
-      respawn_player()
+    -- Only allow respawn if lives remain
+    if lives > 0 then
+      if keyboard.press.ENTER then
+        respawn_player()
+      end
     end
+    -- When lives <= 0, Enter does nothing (yet)
   end
 end
```

**Key Concepts:**
- Conditional UI based on game state
- Branching game flow
- `keyboard.press.ENTER` prevents multiple triggers
- **Single UI function** - Game over and respawn both in `draw_ui()`

**Testing:**
- Lose all 3 lives
- Should see "GAME OVER" instead of respawn message
- Pressing Enter on game over does nothing (this is expected - we'll fix it in Step 8)

---

## Step 7: Adding a Title Screen

**Purpose:** Create a proper game start experience.

**Task:**
1. Start the game on a title screen (player is `isDestroyed = true`)
2. Display game title and start instructions
3. Pressing Enter initializes and starts the game

**New Variable (add near top of file):**
```lua
game_state = "title"  -- "title", "playing"
```

**Implementation - Create init_game function:**
```lua
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
```

**Implementation - Update init function:**
```diff
 init = function()
   init_stars()
   init_player()
-  init_enemies()
   init_lasers()
+  enemies = {}  -- Empty enemies table, don't spawn yet
+
+  -- Start on title screen
+  game_state = "title"
+  player.isDestroyed = true  -- Hide player on title
 end
```

**Implementation - Update update function:**
```diff
 update = function()
   update_stars()
+
+  if game_state == "title" then
+    if keyboard.press.ENTER then
+      init_game()
+    end
+    return
+  end
+
+  -- Playing state
   update_player()
   update_enemies()
   move_lasers()
   fire_laser()
   check_collisions()
 end
```

**Implementation - Update draw_ui function:**

Update `draw_ui()` to handle the title screen using `game_state`. This keeps all text drawing in one place:

```diff
 function draw_ui()
+  -- Title screen
+  if game_state == "title" then
+    screen:drawText("SPACE FLYER", 0, 30, 50, "#FFFFFF")
+    screen:drawText("Press Enter to Take Flight!", 0, -20, 18, "#AAAAAA")
+    return
+  end
+
+  -- Playing state UI
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
```

**Implementation - Update draw function:**

The draw function now always calls `draw_ui()` at the end. The `draw_ui()` function handles game state internally:

```diff
 draw = function()
   screen:clear("rgb(0, 0, 20)")
-
   draw_stars()
-  draw_enemies()
-  draw_player()
-  draw_lasers()
+
+  if game_state == "playing" then
+    draw_enemies()
+    draw_player()
+    draw_lasers()
+  end
+
   draw_ui()
 end
```

**Key Concepts:**
- Game state management with a state variable
- Initialization functions separate from main loop
- `keyboard.press.ENTER` for single key press detection
- Stars continue animating on title screen for visual interest
- **Single UI function** - Title, lives, respawn, and game over all in `draw_ui()`

**Testing:**
- Game should start on title screen with animated stars
- Pressing Enter should start gameplay with 3 lives
- One enemy should spawn

---

## Step 8: Restart from Game Over

**Purpose:** Allow returning to title screen after game over.

**Task:**
When pressing Enter on game over, return to title screen and clear all objects.

**Implementation - Create show_title_screen function:**
```lua
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
```

**Implementation - Update update_respawn:**

Now wire up the game over path to call `show_title_screen()`:

```diff
 function update_respawn()
   player.respawn_timer = player.respawn_timer + 1

   if player.respawn_timer >= RESPAWN_DELAY then
-    -- Only allow respawn if lives remain
-    if lives > 0 then
-      if keyboard.press.ENTER then
+    if keyboard.press.ENTER then
+      if lives <= 0 then
+        show_title_screen()  -- NEW: Go to title on game over
+      else
         respawn_player()
       end
     end
-    -- When lives <= 0, Enter does nothing (yet)
   end
 end
```

**Key Concepts:**
- State transitions
- Cleanup/reset patterns
- Complete game loop (title → playing → game over → title)

**Testing:**
- Lose all lives, wait for message, press Enter
- Should return to title screen
- All enemies and lasers should be cleared
- Pressing Enter should start fresh game with 3 lives

---

## Step 9: Congratulations!

**Purpose:** Celebrate completion and suggest extensions.

**Content:**
- Summarize what was built:
  - Complete game loop (title → playing → game over → title)
  - Player-enemy collision detection
  - Lives system with UI
  - Game state management

**Professional Techniques Learned:**
- **State Machines** - Managing game states (title, playing, game over)
- **Game Loop Pattern** - Complete flow from start to restart
- **UI Systems** - Displaying lives and game messages
- **Initialization Patterns** - Proper game reset and setup
- **Reusing Code** - Applied `isDestroyed` pattern from enemies to player

**Extension Ideas:**
- Add invincibility frames after respawning (flash the player for 2 seconds)
- Add a score system that increases when enemies are destroyed
- Add sound effects for collisions and game over
- Add a high score that persists using `storage:set()` and `storage:get()`
- Add visual explosion effects when player or enemies are destroyed
- Add a wave counter display

**Games Using These Techniques:**
- Galaga, Space Invaders (lives system)
- Most arcade games (title → play → game over loop)
- Asteroids (respawn with brief invincibility)

---

## Technical Notes

### Existing Functions to Modify
- `init_player()` - Add `isDestroyed` and `respawn_timer` properties
- `check_collisions()` - Add player-enemy collision, skip if player destroyed
- `update_player()` - Add destroyed state handling, call `update_respawn()` when destroyed
- `draw_player()` - Add destroyed state handling (early return when destroyed)
- `fire_laser()` - Add destroyed state check at start
- `init()` - Set up title screen state, don't spawn enemies yet
- `update()` - Add game state routing
- `draw()` - Add game state routing, always call `draw_ui()` last

### New Functions to Create
- `player_hit()` - Handle player hit: set destroyed, reset timer, reduce lives
- `respawn_player()` - Reset player position and state
- `update_respawn()` - Handle respawn timer and input (respawn or go to title if no lives)
- `init_game()` - Initialize a new game session (lives, player, enemies, lasers)
- `show_title_screen()` - Transition to title screen, clear objects
- `draw_ui()` - Draw all text/UI (title screen, lives, respawn prompt, game over) based on game state

### New Variables
- `player.isDestroyed` - Boolean for player destroyed state
- `player.respawn_timer` - Frame counter for respawn delay
- `lives` - Number of remaining lives (starts at 3)
- `game_state` - Current game state ("title" or "playing")
- `RESPAWN_DELAY` - Constant for respawn timer (120 frames = 2 seconds)

### Key API Notes (from microStudio Lua API)
- `keyboard.press.ENTER` - Returns true only on the frame the key is first pressed
- `keyboard.ENTER == 1` - Returns 1 while the key is held down
- Use `keyboard.press.KEY` for single actions (menu selection, respawn)
- Use `keyboard.KEY == 1` for continuous actions (movement)

---

## Lesson Flow Summary

1. **Step 0**: Overview and demo
2. **Step 1**: Project setup and requirements
3. **Step 2**: Add `isDestroyed` to player
4. **Step 2b**: Disable player when destroyed (test via console)
5. **Step 2c**: Prevent firing when destroyed (test via console)
6. **Step 3**: Player-enemy collision detection (triggers `isDestroyed` automatically)
7. **Step 4**: Respawn mechanic with timer
8. **Step 5**: Lives system with UI
9. **Step 6**: Game over screen
10. **Step 7**: Title screen and `init_game()`
11. **Step 8**: Complete loop (restart from game over)
12. **Step 9**: Celebration and extensions
