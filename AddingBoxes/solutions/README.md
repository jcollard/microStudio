# Solutions Directory

This directory contains solution code for the "Adding Bounding Boxes" tutorial.

## Files

### step6_solution.lua
Complete solution after finishing Step 6 of the tutorial.

**Based on:** colliding-lasers/starter.lua

**What's included:**
- `create_box()` function for creating bounding box objects (Step 2)
- Both `left_eye` and `right_eye` using bounding boxes
- Updated `init_eyes()` with both eyes using `create_box()` (Steps 3 & 6)
- Updated `update_eyes()` with both eyes using box properties (Steps 4 & 6)
- Updated `draw_eyes()` with both bounding box visualizations (Steps 5 & 6)
- All original functionality preserved: stars, player, lasers

**Key changes from starter code:**

1. **Added create_box function** (Step 2)
   ```lua
   function create_box(x, y, size, vx, vy, color)
     local new_box = {
       x = x, y = y, size = size,
       vx = vx, vy = vy,
       color = color,
       original_color = color
     }
     return new_box
   end
   ```

2. **Refactored init_eyes()** (Steps 3 & 6)
   - Old: 8 separate variables (left_eye_x, left_eye_y, left_eye_vx, left_eye_vy, right_eye_x, etc.)
   - New: 2 box objects using create_box()

3. **Updated update_eyes()** (Steps 4 & 6)
   - Old: `left_eye_x = left_eye_x + left_eye_vx`
   - New: `left_eye.x = left_eye.x + left_eye.vx`
   - Applied to both eyes, 12 changes total (6 per eye)

4. **Enhanced draw_eyes()** (Steps 5 & 6)
   - Added bounding box visualization for debugging
   - Updated sprite drawing to use box properties
   - 6 changes total (3 per eye)

**Values used:**
- **Left Eye:**
  - Position: (0, 0)
  - Velocity: (0.7, 0.57575)
  - Size: 32
  - Color: #FF00FF (magenta)

- **Right Eye:**
  - Position: (0, 0)
  - Velocity: (-0.6, 0.37575)
  - Size: 32
  - Color: #00FFFF (cyan)

## How to Use

Students should try to complete the challenge on their own before looking at the solution. If they get stuck, they can:

1. Compare their code to specific sections of the solution
2. Check that their values match the documented values above
3. Verify their function structure matches the solution
4. Look for the step-by-step comments showing what changed

## Comparing Starter vs Solution

**Original starter.lua structure:**
```lua
init_eyes()
  eye_rotation = 0
  left_eye_x = 0
  left_eye_y = 0
  left_eye_vx = 0.7
  left_eye_vy = 0.57575
  right_eye_x = 0
  right_eye_y = 0
  right_eye_vx = -0.6
  right_eye_vy = 0.37575
```

**Step 6 solution structure:**
```lua
init_eyes()
  eye_rotation = 0
  left_eye = create_box(0, 0, 32, 0.7, 0.57575, "#FF00FF")
  right_eye = create_box(0, 0, 32, -0.6, 0.37575, "#00FFFF")
```

### step7_solution.lua
Complete solution after finishing Step 7 of the tutorial.

**Based on:** colliding-lasers/starter.lua

**What's included:**
- `create_box()` function for creating bounding box objects (Step 2)
- Both eyes (`left_eye` and `right_eye`) using bounding boxes (Steps 3 & 6)
- Player (`player`) using bounding box (Step 7)
- Updated `init_player()` with player using `create_box()` (Step 7)
- Updated `update_player()` with player using box properties (Step 7)
- Updated `draw_player()` with bounding box visualization and rotation fix (Step 7)
- Updated `fire_laser()` to use `player.x` and `player.y` (Step 7)
- All original functionality preserved: stars, eyes, lasers

**Key changes from step6_solution:**

1. **Refactored init_player()** (Step 7)
   - Old: 3 separate variables (x, y, rotation)
   - New: 1 box object using create_box() + rotation separate

2. **Updated update_player()** (Step 7)
   - Old: `x = x - 1`
   - New: `player.x = player.x - 1`
   - Applied to all x references, 6 changes total

3. **Enhanced draw_player()** (Step 7)
   - Added `screen:setDrawRotation(0)` before drawing box (prevents rotation)
   - Added bounding box visualization
   - Updated sprite drawing to use box properties

4. **Updated fire_laser()** (Step 7)
   - Changed `fired_laser.y = y + 15` to `fired_laser.y = player.y + 15`
   - Changed `fired_laser.x = x` to `fired_laser.x = player.x`

**Values used:**
- **Player:**
  - Position: (0, -80)
  - Velocity: (0, 0) - no automatic movement
  - Size: 25
  - Color: #00FF00 (green)

**Critical fix:**
- Must call `screen:setDrawRotation(0)` before drawing bounding box to prevent rotation

### step8_solution.lua
Complete solution after finishing Step 8 of the tutorial.

**Based on:** colliding-lasers/starter.lua

**What's included:**
- `create_box()` function for creating bounding box objects (Step 2)
- Eyes, player, AND lasers all using bounding boxes (Steps 3-8)
- Updated `create_laser()` to return a box instead of plain table (Step 8)
- Updated `draw_lasers()` with bounding box visualization (Step 8)
- All movement and pooling functionality preserved

**Key changes from step7_solution:**

1. **Refactored create_laser()** (Step 8)
   - Old: Returns plain table `{x = 0, y = 200, vy = 2}`
   - New: Returns box using `create_box(0, 200, 8, 0, 2, "#FF0000")`

2. **Enhanced draw_lasers()** (Step 8)
   - Added bounding box visualization for each laser
   - Updated sprite drawing to use box properties
   - 3 new lines added per laser

**Values used:**
- **Lasers:**
  - Starting position: (0, 200) - off-screen
  - Velocity: (0, 2) - moves upward only
  - Size: 8
  - Color: #FF0000 (red)

**Note:** The `move_lasers()` and `fire_laser()` functions work without changes because they already access properties like `.x`, `.y`, and `.vy` which exist on box objects.

### step9_solution.lua
Complete solution after finishing Step 9 of the tutorial.

**Based on:** colliding-lasers/starter.lua

**What's included:**
- `create_box()` function refactored to use `width` and `height` instead of `size` (Step 9)
- All game objects updated to use width/height
- All drawing functions updated to use `width` and `height` properties
- Behavior remains identical - this is a pure refactoring

**Key changes from step8_solution:**

1. **Refactored create_box()** (Step 9)
   - Old signature: `create_box(x, y, size, vx, vy, color)`
   - New signature: `create_box(x, y, width, height, vx, vy, color)`
   - Old properties: `{x, y, size, vx, vy, color, original_color}`
   - New properties: `{x, y, width, height, vx, vy, color, original_color}`

2. **Updated all create_box calls** (Step 9)
   - Eyes: `create_box(0, 0, 32, ...)` → `create_box(0, 0, 32, 32, ...)`
   - Player: `create_box(0, -80, 25, ...)` → `create_box(0, -80, 25, 25, ...)`
   - Lasers: `create_box(0, 200, 8, ...)` → `create_box(0, 200, 8, 8, ...)`

3. **Updated all drawing functions** (Step 9)
   - Old: `screen:fillRect(box.x, box.y, box.size, box.size)`
   - New: `screen:fillRect(box.x, box.y, box.width, box.height)`
   - Applied in: `draw_eyes()`, `draw_player()`, `draw_lasers()`

**Values used:**
All boxes are currently square (width = height):
- **Eyes:** 32x32
- **Player:** 25x25
- **Lasers:** 8x8

**Why this change?**
- Industry standard: Most game engines use width/height
- More flexible: Can support rectangular (non-square) boxes
- Better accuracy: More precise collision detection for non-square sprites
- Prepares for collision detection in future lessons

**Total changes:** 7 functions, 10 modifications

## What's Next?

After completing Step 9, students will be ready to:
1. Implement the `boxes_colliding()` function to detect collisions
2. Detect laser-eye collisions using the width/height properties
3. Add collision response behavior (remove eyes when hit)
4. Add game mechanics (score, win/lose conditions, etc.)

These topics will be covered in future lessons!
