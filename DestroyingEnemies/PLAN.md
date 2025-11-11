# Destroying Enemies Challenge - Lesson Plan

## Overview
Students will learn collision detection and destruction mechanics by implementing a system to detect when lasers hit enemy eyes and destroy them. This challenge builds directly on the "Adding Boxes" lesson and teaches the key concepts of:
- AABB (Axis-Aligned Bounding Box) collision detection
- Collision response (what happens when objects collide)
- Object lifecycle management (creation, status change, destruction)
- Dynamic filtering and removal

## Starting Point
Students begin with `starter_code.lua` which is the complete Step 9 solution from the "Adding Boxes" lesson. This includes:
- `create_box()` and `draw_box()` helper functions with width/height support
- All game objects (player, eyes, lasers) with bounding boxes
- Working game mechanics (movement, firing, bouncing)

## Challenge Structure (Estimated 7-8 steps)

### Step 0: Introduction & Overview
**Goal:** Understand the challenge and what will be built

**Content:**
- Recap of the "Adding Boxes" lesson
- Introduce the concept: "Your lasers are firing, but they pass right through the eyes!"
- Visual explanation of collision detection and destruction
- Show what the final result will look like (preview embedded game)
- Explain the learning objectives:
  - Implement collision detection
  - Add collision response
  - Track enemy state
  - Remove destroyed enemies

**Student Activity:** None (informational)

**Key Concepts:** AABB collision detection, collision response, object state

---

### Step 1: Set Up Your Project
**Goal:** Prepare your code for the collision detection challenge

**Content:**
- **Option A - Continue Your Work:** If you completed the "Adding Boxes" lesson, you can keep using your own project! Just make sure you're at Step 9 (with width/height implemented).
- **Option B - Start Fresh:** If you want a clean slate, we've provided a starter project with all the code ready to go. Just clone it and you're ready to begin.
- Either way, verify your game is working: eyes bounce around, lasers fire correctly, no errors in console

**What You Need:**
- A project with bounding boxes on eyes, player, and lasers (width/height based)
- All game objects moving and drawing correctly
- No console errors

**Student Activity:**
- Choose Option A (use your existing project) or Option B (clone the starter)
- Run the project and verify:
  - Eyes bounce around the screen
  - Lasers fire when pressing SPACE
  - All bounding boxes are visible
  - No error messages in the console

**Success Criteria:** Game runs without errors, eyes bounce, lasers fire

---

### Step 2: Add `isDestroyed` Property to Eyes
**Goal:** Track whether an eye has been destroyed

**Content:**
- Explain the concept of object state tracking
- Show that we need a way to mark eyes as "destroyed" but keep them in the table initially
- Demonstrate adding a new property during initialization
- Explain why we do this (lazy removal is safer than immediate removal during iteration)

**Changes in `init_eyes()`:**
```lua
left_eye = create_box(0, 0, 28, 28, 0.7, 0.57575, "#FF00FF")
left_eye.isDestroyed = false  -- NEW: Track if this eye is destroyed

right_eye = create_box(0, 0, 28, 28, -0.6, 0.37575, "#00FFFF")
right_eye.isDestroyed = false  -- NEW: Track if this eye is destroyed
```

**Student Activity:**
- Add `isDestroyed` property initialization to both eyes
- Verify the code still runs

**Success Criteria:** Properties added, game still runs normally

---

### Step 3: Skip Movement for Destroyed Eyes (Part 1 - Left Eye)
**Goal:** Don't update destroyed enemies, use `isDestroyed` to control behavior

**Content:**
- Explain that destroyed eyes shouldn't move or bounce anymore
- Show how to use the `isDestroyed` property to skip movement logic
- Demonstrate wrapping movement code in an `if not eye.isDestroyed then` check
- Start with just the left eye so students understand the pattern

**Update `update_eyes()`:**
```lua
function update_eyes()
  eye_rotation = eye_rotation + 12

  -- Left eye - ONLY UPDATE IF NOT DESTROYED
  if not left_eye.isDestroyed then
    -- All existing movement and boundary code goes here
    left_eye.x = left_eye.x + left_eye.vx
    left_eye.y = left_eye.y + left_eye.vy

    -- ... all boundary checks ...
    if left_eye.x < -100 then left_eye.vx = 0.7 end
    if left_eye.x > 100 then left_eye.vx = -0.7 end
    if left_eye.y < -100 then left_eye.vy = 0.57575 end
    if left_eye.y > 100 then left_eye.vy = -0.57575 end
  end

  -- Right eye (unchanged for now)
  right_eye.x = right_eye.x + right_eye.vx
  right_eye.y = right_eye.y + right_eye.vy
  -- ... boundary checks ...
end
```

**Student Activity:**
- Wrap the left eye's movement and boundary code with `if not left_eye.isDestroyed then ... end`
- Keep indentation correct!
- Test it: In the console, type `left_eye.isDestroyed = true` and watch the left eye stop
- Test it again: Type `left_eye.isDestroyed = false` and watch it start moving again

**Success Criteria:** Left eye stops moving when `isDestroyed` is true

**Testing Checklist:**
- Run game normally → left eye bounces
- In console: `left_eye.isDestroyed = true` → left eye stops and doesn't bounce
- In console: `left_eye.isDestroyed = false` → left eye bounces again

---

### Step 4: Skip Movement for Destroyed Eyes (Part 2 - Right Eye Challenge)
**Goal:** Apply the same pattern to the right eye

**Content:**
- This is a challenge step - students apply what they learned in Step 3
- Wrap the right eye's movement and boundary code with the same pattern
- Emphasize that the pattern is identical: `if not right_eye.isDestroyed then`

**Update `update_eyes()`:**
```lua
-- Right eye - NOW WITH THE SAME CHECK!
if not right_eye.isDestroyed then
  right_eye.x = right_eye.x + right_eye.vx
  right_eye.y = right_eye.y + right_eye.vy

  -- ... all boundary checks ...
  if right_eye.x < -100 then right_eye.vx = 0.6 end
  if right_eye.x > 100 then right_eye.vx = -0.6 end
  if right_eye.y < -100 then right_eye.vy = 0.37575 end
  if right_eye.y > 100 then right_eye.vy = -0.37575 end
end
```

**Student Activity:**
- Apply the same pattern to the right eye
- Test in console: `right_eye.isDestroyed = true` → right eye stops
- Test: `right_eye.isDestroyed = false` → right eye bounces again
- Test both: `left_eye.isDestroyed = true` and `right_eye.isDestroyed = true` → both stop

**Success Criteria:** Both eyes can be independently marked as destroyed and stop moving

**Testing Checklist:**
- `left_eye.isDestroyed = true` → left eye stops, right eye keeps moving
- `right_eye.isDestroyed = true` → right eye stops, left eye keeps moving
- Both destroyed → both stop completely
- Set both to false → both bounce again

---

### Step 5: Stop Drawing Destroyed Eyes (Part 1 - Left Eye)
**Goal:** Don't draw destroyed enemies, use `isDestroyed` to control visibility

**Content:**
- Explain that destroyed eyes should no longer be visible
- Show how to use the `isDestroyed` property to skip drawing logic
- Demonstrate wrapping drawing code in an `if not eye.isDestroyed then` check
- Start with just the left eye so students understand the pattern

**Update `draw_eyes()` - Left Eye Only:**
```lua
function draw_eyes()
  -- Left eye - ONLY DRAW IF NOT DESTROYED
  if not left_eye.isDestroyed then
    draw_box(left_eye)
    screen:setDrawScale(1, 1)
    screen:setDrawRotation(eye_rotation)
    screen:drawSprite("googlya", left_eye.x, left_eye.y, 32, 32)
  end

  -- Right eye (unchanged for now)
  screen:setDrawRotation(-eye_rotation)
  screen:drawSprite("googlyb", right_eye.x, right_eye.y, 32, 32)

  screen:setDrawRotation(0)
end
```

**Student Activity:**
- Wrap the left eye's drawing code with `if not left_eye.isDestroyed then ... end`
- Keep indentation correct!
- Test it: In the console, type `left_eye.isDestroyed = true` and watch the left eye disappear
- Test it again: Type `left_eye.isDestroyed = false` and watch it reappear

**Success Criteria:** Left eye stops drawing when `isDestroyed` is true

**Testing Checklist:**
- Run game normally → left eye displays (bounding box + sprite)
- In console: `left_eye.isDestroyed = true` → left eye disappears completely
- In console: `left_eye.isDestroyed = false` → left eye appears again
- Right eye continues to display normally the entire time

---

### Step 5b: Stop Drawing Destroyed Eyes (Part 2 - Right Eye Challenge)
**Goal:** Apply the same pattern to the right eye

**Content:**
- This is a challenge step - students apply what they learned in Step 5
- Wrap the right eye's drawing code with the same pattern
- Emphasize that the pattern is identical: `if not right_eye.isDestroyed then`
- Note: Don't forget to update the bounding box drawing for right eye too!

**Update `draw_eyes()` - Right Eye:**
```lua
-- Right eye - NOW WITH THE SAME CHECK!
if not right_eye.isDestroyed then
  draw_box(right_eye)  -- NEW: Also draw the right eye's bounding box
  screen:setDrawRotation(-eye_rotation)
  screen:drawSprite("googlyb", right_eye.x, right_eye.y, 32, 32)
end

screen:setDrawRotation(0)
```

**Student Activity:**
- Apply the same pattern to the right eye
- Make sure to wrap both the bounding box drawing AND the sprite drawing
- Test in console: `right_eye.isDestroyed = true` → right eye disappears
- Test: `right_eye.isDestroyed = false` → right eye appears again
- Test both: `left_eye.isDestroyed = true` and `right_eye.isDestroyed = true` → both disappear

**Success Criteria:** Both eyes can be independently marked as destroyed and stop drawing

**Testing Checklist:**
- `left_eye.isDestroyed = true` → left eye disappears, right eye visible
- `right_eye.isDestroyed = true` → right eye disappears, left eye visible
- Both destroyed → both disappear completely
- Set both to false → both appear again

---

### Step 6: Add the `boxes_colliding()` Function
**Goal:** Set up collision detection logic

**Content:**
- Brief recap: "You've already learned AABB collision detection in the Collision Challenge!"
- Important note about box properties: **Boxes now use `width` and `height` instead of `size`**
  - In the Collision Challenge, boxes used a single `size` property
  - In the Adding Boxes lesson, you refactored to separate `width` and `height`
  - This makes collision detection more accurate for rectangular shapes (like lasers!)
- Provide the `boxes_colliding(box1, box2)` function (they copy it in, don't implement from scratch)
- Explain it takes two boxes and returns `true` if colliding, `false` otherwise

**Function to Add:**
```lua
function boxes_colliding(box1, box2)
  -- Check if boxes overlap on x-axis
  local no_x_overlap = (box1.x + box1.width/2 < box2.x - box2.width/2) or
                       (box1.x - box1.width/2 > box2.x + box2.width/2)

  -- Check if boxes overlap on y-axis
  local no_y_overlap = (box1.y + box1.height/2 < box2.y - box2.height/2) or
                       (box1.y - box1.height/2 > box2.y + box2.height/2)

  -- If there's NO gap on either axis, they're colliding
  return not (no_x_overlap or no_y_overlap)
end
```

**⚠️ Key Difference from Collision Challenge:**
- Old: `box.size` (single value for square boxes)
- New: `box.width` and `box.height` (supports rectangles!)
- The collision algorithm uses these new properties to detect collisions accurately

**Student Activity:**
- Copy the `boxes_colliding()` function to their code
- Place it near the top with other helper functions
- Test: Call it and verify it returns true/false without errors

**Success Criteria:** Function added and callable without errors

---

### Step 7: Detect Laser-Eye Collisions and Mark Eyes as Destroyed
**Goal:** First real collision response - detect when lasers hit eyes

**Content:**
- Explain that we'll do collision detection in the `update()` function (update before draw)
- Show the logic: loop through all lasers, check against all eyes
- When collision detected: mark eye as destroyed and stop movement
- Explain why we check `not isDestroyed` (only check living eyes)
- The eye stops moving automatically because of Step 3 & 4 checks
- The eye stops drawing automatically because of Step 5 & 5b checks

**New function `check_collisions()`:**
```lua
function check_collisions()
  -- Check each laser against each eye
  for laser_idx, laser in pairs(lasers) do
    -- Check laser against left eye
    if not left_eye.isDestroyed then
      if boxes_colliding(laser, left_eye) then
        left_eye.isDestroyed = true  -- Mark as destroyed
      end
    end

    -- Check laser against right eye
    if not right_eye.isDestroyed then
      if boxes_colliding(laser, right_eye) then
        right_eye.isDestroyed = true  -- Mark as destroyed
      end
    end
  end
end
```

**Update `update()` function:**
```lua
update = function()
  update_stars()
  update_player()
  update_eyes()
  move_lasers()
  fire_laser()
  check_collisions()  -- NEW: Check for collisions after all movement
end
```

**Student Activity:**
- Add the `check_collisions()` function
- Call it from the `update()` function
- Test: Fire lasers at the eyes and watch them stop and disappear!
- Test: Hit left eye, then right eye - both should disappear

**Success Criteria:** Eyes are destroyed when lasers hit them

**Testing Checklist:**
- Fire laser at left eye → eye stops moving and disappears
- Fire laser at right eye → eye stops moving and disappears
- Lasers can hit multiple times (no error)
- After being hit, eyes don't move, don't draw

---

### Step 8: Congratulations & Next Steps
**Goal:** Celebrate completion and preview future enhancements

**Content:**
- Celebrate completing the challenge
- Recap what was learned:
  - Object state management (`isDestroyed`)
  - Using state to control behavior (update/draw logic)
  - AABB collision detection (from before)
  - Collision response (marking objects as destroyed)
  - Making game interactions feel satisfying (visual feedback)
- Preview next challenges:
  - Respawning enemies
  - Multiple waves
  - Different enemy types
  - Power-ups
  - Sound effects
- Challenge ideas:
  - Add third enemy type
  - Implement lives system
  - Add difficulty progression
  - Track accuracy (shots fired vs hits)

**Student Activity:** None (celebratory/informational)

---

## Key Teaching Patterns

### 1. Progressive Visibility
- Step 4: Make destruction visible (eyes stop moving)
- Step 6: Make destruction complete (eyes disappear)
- Step 7: Add satisfaction (visual feedback)

### 2. State Management Pattern
- Add property: `isDestroyed`
- Check property: `if not eye.isDestroyed then`
- Use in multiple places: update, draw, collision

### 3. Safe Removal Pattern
- Don't remove from tables during iteration (causes bugs)
- Instead, mark as destroyed and skip in loops
- Can clean up table later if needed

## Technical Skills Covered
- ✅ AABB collision detection algorithm
- ✅ Loop nesting (laser vs eye)
- ✅ Conditional checks with properties
- ✅ Object state tracking
- ✅ Lazy removal pattern
- ✅ Input feedback loops
- ✅ Function composition
- ✅ Table iteration patterns

## Student Ownership Language
- Always use "your game objects", "your collision system", "your enemies"
- Change language to "your" instead of "our"
- Emphasize they're building their own game

## Comparison to AddingBoxes
| Aspect | AddingBoxes | DestroyingEnemies |
|--------|-------------|-------------------|
| **Focus** | Data structure (boxes) | Game logic (collision) |
| **Key Concept** | Helper functions | State management |
| **Difficulty** | Guided (90% done) | Challenge-based |
| **Main Function** | `create_box()`, `draw_box()` | `boxes_colliding()`, `check_collisions()` |
| **Student Writes** | Initialization calls | Core game logic |
| **Main Loop** | Object creation/drawing | Collision detection loop |
