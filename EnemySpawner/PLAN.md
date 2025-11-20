# Enemy Spawner - Challenge Plan

## Overview
**Goal**: Create a dynamic enemy spawning system with wave mechanics and object pooling optimization.

**Key Concept**: Instead of creating all enemies at game start, students will learn to dynamically spawn enemies during gameplay, reuse destroyed enemies to optimize memory (object pooling), and implement escalating difficulty through wave mechanics.

**Starting Point**: `AbstractingEnemies/solutions/step10_solution.lua` (or student's own project with enemies table)

---

## HTML Implementation Guidelines

### Design Philosophy
- **Keep it simple and sparse**: Don't overload pages with excessive styling or flare
- **Focus on the essentials**: Clear explanations, working code, and testing instructions
- **Minimize visual noise**: Use consistent, clean styling without distractions

### Code Display Functions

**JavaScript Libraries (via CDN)**:
- **Syntax Highlighting**: [Highlight.js](https://highlightjs.org/) - Lightweight (~50KB), excellent Lua support
  - CDN: `https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js`
  - CSS: `https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css`
- **Diff Generation**: [jsdiff](https://github.com/kpdecker/jsdiff) - Simple, flexible diff library
  - CDN: `https://cdn.jsdelivr.net/npm/diff@5.1.0/dist/diff.min.js`

**Implementation**: Create a shared `codeblocks.js` file (easier to maintain than inline functions)

**Required Functions** (in `codeblocks.js`):

1. **`renderCodeBlock(elementId, code, language = 'lua')`**
   - Renders a syntax-highlighted code block into the specified element
   - Uses highlight.js for Lua syntax highlighting
   - Includes a "Copy Code" button in the top-right corner
   - Formatted HTML injected directly into the element
   - Example: `renderCodeBlock('step2-code', 'function spawn_enemy()...')`

2. **`renderDiffBlock(elementId, oldCode, newCode, description = '')`**
   - Renders a side-by-side diff view into the specified element
   - Accepts two code strings (before and after)
   - Left side (red background): Lines removed/changed
   - Right side (green background): Lines added/changed
   - Shows line numbers on both sides
   - Optional description header
   - Uses jsdiff library to compute differences
   - Includes a "Copy Code" button on the right (new) side for easy copying
   - Example: `renderDiffBlock('step4-diff', oldCode, newCode, 'Add object pooling')`

**Example Usage in HTML**:
```html
<!-- Simple code block -->
<div id="step2-code"></div>
<script>
  renderCodeBlock('step2-code', `function spawn_enemy()
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 200
  enemy.y = 100
  enemy.vx = (math.random() - 0.5) * 2
  enemy.vy = (math.random() - 0.5) * 2
  enemy.color = "#FF6B35"
end`);
</script>

<!-- Diff view showing changes -->
<div id="step4-diff"></div>
<script>
  const oldCode = `function spawn_enemy()
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 200
  enemy.y = 100
  enemy.vx = (math.random() - 0.5) * 2
  enemy.vy = (math.random() - 0.5) * 2
  enemy.color = "#FF6B35"
end`;

  const newCode = `function spawn_enemy()
  -- First, try to find a destroyed enemy to reuse
  for ix, enemy in pairs(enemies) do
    if enemy.isDestroyed then
      enemy.x = (math.random() - 0.5) * 200
      enemy.y = 100
      enemy.vx = (math.random() - 0.5) * 2
      enemy.vy = (math.random() - 0.5) * 2
      enemy.isDestroyed = false
      return
    end
  end

  -- No destroyed enemies found - create a new one
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 200
  enemy.y = 100
  enemy.vx = (math.random() - 0.5) * 2
  enemy.vy = (math.random() - 0.5) * 2
  enemy.color = "#FF6B35"
end`;

  renderDiffBlock('step4-diff', oldCode, newCode, 'Add object pooling optimization');
</script>
```

**Benefits**:
- **Maintainable**: Code changes only require updating JavaScript strings, not HTML structure
- **Consistent**: All code blocks use the same rendering and styling
- **Professional**: Diffs clearly show what changed, making it easier for students to understand
- **Reusable**: Same functions work across all lesson steps
- **Student-Friendly**: Copy buttons make it easy to grab working code

**CDN Setup** (add to HTML `<head>`):
```html
<!-- Highlight.js for syntax highlighting -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>

<!-- jsdiff for computing code differences -->
<script src="https://cdn.jsdelivr.net/npm/diff@5.1.0/dist/diff.min.js"></script>

<!-- Our custom code rendering functions -->
<script src="codeblocks.js"></script>
```

---

## Learning Progression

### Step 0: Welcome - Dynamic Spawning Introduction
- Show the finished project with embedded demo
- Explain the current system: all enemies are created once in `init_enemies()`
- Introduce the problem: What if we want enemies to appear during gameplay?
- Introduce the solution: **Dynamic spawning with spawn_enemy()**
- Preview the challenge: Spawn new enemies, optimize memory, create escalating waves
- Explain what they'll build: A spawn system that creates increasingly difficult enemy waves

### Step 1: Getting Started - Clone or Continue
**Two Options for Students**:
- **Option 1 (Recommended)**: Clone the starter project (link to be created)
- **Option 2**: Continue from their current project if it uses an enemies table

**Requirements**:
- Must have an `enemies` table
- Must have `create_enemy()`, `init_enemies()`, `update_enemies()`, `draw_enemies()` functions
- Enemies must have an `isDestroyed` property

### Step 2: Create spawn_enemy() Function
**New Concept**: Dynamically create enemies during gameplay, not just at initialization

**Task**: Create a `spawn_enemy()` function that:
- Takes no parameters (uses random values)
- Creates a new enemy using `create_enemy("enemy_ship", 32, 32)`
- Sets the enemy's X position to a random value between -100 and 100
- Sets the enemy's Y position to 100 (top of screen)
- Sets the enemy's velocity to random values:
  - `vx` = random value between -1 and 1
  - `vy` = random value between -1 and 1
- Sets the enemy's color (optional, for visual variety)
- The enemy is automatically added to the `enemies` table by `create_enemy()`

**Code changes**:
```lua
function spawn_enemy()
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 200  -- Random X between -100 and 100
  enemy.y = 100  -- Top of screen
  enemy.vx = (math.random() - 0.5) * 2  -- Random velocity between -1 and 1
  enemy.vy = (math.random() - 0.5) * 2  -- Random velocity between -1 and 1
  enemy.color = "#FF6B35"  -- Orange
end
```

**Testing in Console**:
Students should test by typing:
```lua
spawn_enemy()
```

A new enemy should appear at the top of the screen and move in a random direction! They can call it multiple times to spawn multiple enemies.

**Key teaching moment**: Functions can create game objects on-demand, not just during initialization. This is fundamental to dynamic gameplay.

### Step 3: Replace init_enemies() to Use spawn_enemy()
**New Concept**: Use our new spawning function to initialize enemies

**Task**: Update `init_enemies()` to:
- Clear the enemies table: `enemies = {}`
- Call `spawn_enemy()` once to start with 1 enemy
- Remove any manual enemy creation code

**Code changes**:
```lua
function init_enemies()
  enemies = {}

  -- Spawn 1 enemy at the start
  spawn_enemy()
end
```

**Testing**: Run the game - 1 enemy should spawn at the top and move in a random direction!

**Key teaching moment**: By abstracting spawning into a function, we can easily control how many enemies start in the game. Change this to call `spawn_enemy()` multiple times and you instantly have more enemies!

### Step 4: Optimize with Object Pooling
**New Concept**: Reuse destroyed enemies instead of constantly creating new ones (object pooling)

**The Problem**: Every time we call `spawn_enemy()`, we add a new enemy to the table. After spawning and destroying hundreds of enemies, the table gets huge with destroyed enemies taking up memory.

**The Solution**: Before creating a new enemy, check if there's already a destroyed enemy in the table. If there is, "resurrect" it by resetting its properties instead of creating a brand new one.

**Task**: Update `spawn_enemy()` to:
1. Loop through the `enemies` table
2. Look for an enemy where `isDestroyed == true`
3. If found: Reset that enemy's properties (position, velocity, `isDestroyed = false`) and return early
4. If NOT found: Create a new enemy (the existing code)

**Code changes**:
```lua
function spawn_enemy()
  -- First, try to find a destroyed enemy to reuse
  for ix, enemy in pairs(enemies) do
    if enemy.isDestroyed then
      -- Reuse this enemy!
      enemy.x = (math.random() - 0.5) * 200
      enemy.y = 100
      enemy.vx = (math.random() - 0.5) * 2
      enemy.vy = (math.random() - 0.5) * 2
      enemy.isDestroyed = false
      return  -- Exit early - we reused an enemy!
    end
  end

  -- No destroyed enemies found - create a new one
  local enemy = create_enemy("enemy_ship", 32, 32)
  enemy.x = (math.random() - 0.5) * 200
  enemy.y = 100
  enemy.vx = (math.random() - 0.5) * 2
  enemy.vy = (math.random() - 0.5) * 2
  enemy.color = "#FF6B35"
end
```

**Testing in Console**:
```lua
-- Check initial table size
print(#enemies)  -- Should print 1

-- Destroy the enemy (shoot it or use console)
-- Then spawn new enemies
spawn_enemy()
spawn_enemy()
spawn_enemy()

-- Check table size again
print(#enemies)  -- Should be 3 (1 reused + 2 new)

-- Destroy all enemies, then spawn again
spawn_enemy()

-- Check table size
print(#enemies)  -- Should STILL be 3! (reused a destroyed enemy)
```

**Key teaching moment**: This is called "object pooling" - a real game optimization technique used in professional games. Instead of creating and destroying thousands of objects (which is slow), we reuse them!

### Step 5: Create all_enemies_destroyed() Function
**New Concept**: Check game state to trigger events (wave completion)

**Task**: Create an `all_enemies_destroyed()` function that:
- Loops through the entire `enemies` table
- Checks if ALL enemies have `isDestroyed == true`
- Returns `true` if all are destroyed, `false` otherwise

**Code changes**:
```lua
function all_enemies_destroyed()
  for ix, enemy in pairs(enemies) do
    if not enemy.isDestroyed then
      return false  -- Found a living enemy - not all destroyed!
    end
  end
  return true  -- Made it through the loop - all destroyed!
end
```

**Testing in Console**:
```lua
-- With enemies on screen
all_enemies_destroyed()  -- Should print: false

-- After destroying all enemies
all_enemies_destroyed()  -- Should print: true
```

**Key teaching moment**: Functions can answer questions about game state. This pattern (checking if a condition is met) is used everywhere in games: "Is the player dead?", "Is the level complete?", "Did I collect all coins?"

### Step 6: Auto-Spawn After All Enemies Destroyed
**New Concept**: React to game state changes to create dynamic gameplay

**Task**: Update `update_enemies()` to:
- Call `all_enemies_destroyed()` to check if all enemies are gone
- If true: Call `spawn_enemy()` to spawn one new enemy

**Code changes** (add to the END of `update_enemies()`):
```lua
function update_enemies()
  -- ... existing update code (position updates, boundary checks, etc.)

  -- NEW: Check if all enemies are destroyed
  if all_enemies_destroyed() then
    spawn_enemy()  -- Spawn one new enemy
  end
end
```

**Testing**: Play the game and destroy all enemies. As soon as the last enemy is destroyed, a new one should spawn at the top!

**Key teaching moment**: The game reacts to player actions! This creates a continuous challenge - you can never truly "win" because enemies keep spawning.

### Step 7: Create spawn_enemy_wave() Function
**New Concept**: Escalating difficulty through wave mechanics

**The Goal**: Each wave should have MORE enemies than the last wave. How do we know how many enemies to spawn? Count how many are in the table, then spawn that many PLUS one more!

**Task**: Create a `spawn_enemy_wave()` function that:
- Uses a traditional for loop: `for i = 1, #enemies do`
  - `#enemies` gives the current size of the enemies table
- Inside the loop: Call `spawn_enemy()` once per enemy
- After the loop: Call `spawn_enemy()` ONE more time
- Result: Spawns `#enemies + 1` total enemies

**Code changes**:
```lua
function spawn_enemy_wave()
  -- Spawn one enemy for each enemy currently in the table
  for i = 1, #enemies do
    spawn_enemy()
  end

  -- Spawn ONE more enemy to increase difficulty
  spawn_enemy()
end
```

**Testing in Console**:
```lua
spawn_enemy_wave()
```

Lots of new enemies should spawn at the top! If you started with 1 enemy, you'll spawn 2 more. The next wave would spawn 3, then 4, then 5...

**Key teaching moment**:
- `#enemies` gives the length of the table
- Each wave spawns more enemies than the last, creating escalating difficulty
- Traditional for loops (`for i = 1, n do`) are perfect when you know exactly how many times to loop

### Step 8: Implement Wave System
**New Concept**: Replace single-spawn with wave-spawn for better gameplay

**Task**: Update `update_enemies()` to:
- Replace the `spawn_enemy()` call with `spawn_enemy_wave()`

**Code changes**:
```lua
function update_enemies()
  -- ... existing update code ...

  -- Check if all enemies are destroyed
  if all_enemies_destroyed() then
    spawn_enemy_wave()  -- Spawn a whole wave!
  end
end
```

**Testing**: Play the game!
- Wave 1: 1 enemy (from `init_enemies()`)
- Destroy all → Wave 2: 2 enemies spawn
- Destroy all → Wave 3: 3 enemies spawn
- Destroy all → Wave 4: 4 enemies spawn
- The game gets progressively harder!

**Key teaching moment**: Small changes create big impacts! By replacing one function call, we changed the entire game's difficulty curve and created a wave-based gameplay loop.

### Step 9: Congratulations! 🎉
**Celebration Step**: Recap and preview

**What Students Learned**:
- ✅ Dynamic spawning - creating objects during gameplay
- ✅ Object pooling - reusing destroyed objects for optimization
- ✅ State checking - using functions to ask questions about game state
- ✅ Event-driven gameplay - reacting to conditions (all enemies destroyed)
- ✅ Wave mechanics - escalating difficulty
- ✅ Traditional for loops - iterating a specific number of times

**Real Game Development**:
- These techniques are used in professional games
- Object pooling is essential for performance (especially in bullet hell games!)
- Wave systems create engaging gameplay loops

**What's Next**:
In the next lesson, we'll add **collision detection with the player ship**! Enemies will be able to destroy your ship, adding real challenge and stakes to the game. Get ready to implement health systems, invincibility frames, and game over conditions!

---

## Summary

| Step | Focus | Code Changes | Testing Method |
|------|-------|--------------|----------------|
| 0 | Introduction | None | View demo |
| 1 | Getting Started | Clone or continue | N/A |
| 2 | `spawn_enemy()` basic | New function | Console: `spawn_enemy()` |
| 3 | Use in `init_enemies()` | Update `init_enemies()` | Run game |
| 4 | Object pooling optimization | Update `spawn_enemy()` | Console: `print(#enemies)` |
| 5 | `all_enemies_destroyed()` | New function | Console: test with/without enemies |
| 6 | Auto-spawn single enemy | Update `update_enemies()` | Destroy all enemies in-game |
| 7 | `spawn_enemy_wave()` | New function | Console: `spawn_enemy_wave()` |
| 8 | Implement wave system | Update `update_enemies()` | Play game through multiple waves |
| 9 | Celebration | None | Reflect on learning |

---

## Key Teaching Points

1. **Dynamic Object Creation**: Objects can be created during gameplay, not just initialization
2. **Object Pooling**: Reusing objects is faster and more memory-efficient than creating new ones
3. **State-Based Logic**: Check game state to trigger events (`all_enemies_destroyed()`)
4. **Factory Functions**: `spawn_enemy()` uses `create_enemy()` internally - functions calling functions!
5. **Escalating Difficulty**: Wave mechanics create engaging gameplay loops
6. **Traditional For Loops**: `for i = 1, n do` - used when you know the exact iteration count
7. **Code Reuse**: `spawn_enemy_wave()` calls `spawn_enemy()` - small building blocks create complex systems
8. **Professional Techniques**: Object pooling and wave systems are used in real game development

---

## Technical Notes

### Object Pooling Pattern
The optimization in Step 4 introduces "object pooling":
- **Problem**: Creating/destroying objects is computationally expensive
- **Solution**: Mark objects as "destroyed" but keep them in the table
- **Benefit**: When spawning, reuse destroyed objects instead of creating new ones
- **Result**: Constant memory usage, better performance

This is the same technique used for the laser system in previous lessons.

### Wave Difficulty Curve
The wave system uses a simple but effective formula:
- Wave N spawns `#enemies + 1` enemies
- Starting with 1 enemy:
  - Wave 1: 1 enemy
  - Wave 2: 2 enemies
  - Wave 3: 3 enemies
  - Wave 4: 4 enemies
  - Wave N: N enemies

This creates a linear difficulty increase that feels fair to players.

### State Checking Pattern
`all_enemies_destroyed()` demonstrates a common game programming pattern:
```lua
function check_condition()
  for ix, item in pairs(items) do
    if not meets_condition(item) then
      return false  -- Early exit on first failure
    end
  end
  return true  -- All items met the condition
end
```

This pattern is used for:
- "Are all coins collected?"
- "Are all doors unlocked?"
- "Are all enemies defeated?"
- "Is the player inventory full?"

---

## Prerequisites

Students should have completed:
- **Abstracting Enemies** lesson (required)
  - Understanding of the `enemies` table
  - Familiarity with `create_enemy()` factory function
  - Understanding of `isDestroyed` property
  - Experience with `for ix, enemy in pairs(enemies)` loops

Students should understand:
- Tables and table iteration
- Factory functions
- Object properties
- Boolean logic
- Function return values
- Traditional for loops (`for i = 1, n do`)

---

## Common Student Mistakes

1. **Forgetting to set `isDestroyed = false` in object pooling**: Reused enemies stay destroyed!
2. **Not returning early in object pooling**: Creates new enemy even after reusing one
3. **Off-by-one in wave spawning**: Forgetting the `+1` spawn after the loop
4. **Infinite spawning**: Calling `spawn_enemy()` in update without checking if enemies are destroyed
5. **Not testing in console**: Students should test functions before integrating them

---

## Assessment Checkpoints

Students successfully complete this lesson if they can:
- [ ] Explain what object pooling is and why it's useful
- [ ] Create a function that spawns enemies dynamically
- [ ] Check game state using a boolean function
- [ ] Implement escalating difficulty through wave mechanics
- [ ] Use traditional for loops with table length (`#enemies`)
- [ ] Debug using console commands to test individual functions

---

## Estimated Time
- **Fast learners**: 30-45 minutes
- **Average learners**: 60-90 minutes
- **Struggling learners**: 90-120 minutes

Most time is spent on:
- Understanding object pooling (Step 4)
- Testing and debugging the wave system (Steps 7-8)
- Console testing and verification

---

## Implementation Notes for HTML Pages

### When to Use Code Blocks vs Diffs

**Use `renderCode()` for**:
- Step 2, 3, 5, 7: New functions being written from scratch
- Console testing examples
- Final complete implementations

**Use `renderDiff()` for**:
- Step 4: Showing how spawn_enemy() changes with object pooling
- Step 6: Adding code to the end of update_enemies()
- Step 8: Replacing spawn_enemy() call with spawn_enemy_wave()
- Any time existing code is being modified

### Page Structure Template

Each step HTML should follow this minimal structure:
```html
<h2>Step N: Title</h2>
<div class="step-content">
    <p>Brief introduction (1-2 sentences)</p>

    <div class="info-box">
        <h3>Key Concept</h3>
        <p>Explanation of the new concept</p>
    </div>

    <h3>Task</h3>
    <p>What the student needs to do</p>

    <!-- Code or diff -->
    <div id="codeblock"></div>
    <script>/* render code here */</script>

    <h3>Testing</h3>
    <p>How to verify it works</p>
    <div id="test-code"></div>
    <script>/* render test code here */</script>

    <div class="success-box">
        <h3>Key Teaching Moment</h3>
        <p>Why this matters / what they learned</p>
    </div>
</div>
```

### Style Guidelines

**DO**:
- Use clear headings (h2, h3)
- Use info-box for explanations
- Use success-box for key insights
- Keep explanations concise (1-3 sentences)
- Show code immediately after describing it
- Provide testing instructions

**DON'T**:
- Add unnecessary graphics or animations
- Use excessive emojis (one per major section is enough)
- Create complex layouts
- Add "helpful tips" that aren't essential
- Include tangential information
- Use multiple colors/themes within a page

### Diff Display Specifications

The diff renderer should display **side-by-side view only** with:
- Monospace font (Consolas, Monaco, 'Courier New')
- Line numbers on both sides
- Pale red (#ffebee) background for removed lines
- Pale green (#e8f5e9) background for added lines
- Darker red (#c62828) text for removed code
- Darker green (#2e7d32) text for added code
- Show unchanged context lines (3 lines before/after changes)
- Include a header with the description if provided
- "Copy Code" button on the right (new code) side

Example visual layout:
```
┌──────────────────────────────────────────────────────┐
│ Add object pooling optimization        [Copy Code]  │
├──────────────────────┬───────────────────────────────┤
│ Before               │ After                         │
├──────────────────────┼───────────────────────────────┤
│ 1  function spawn... │ 1  function spawn...          │
│ 2    local enemy...  │ 2    -- First, try to find..  │
│                      │ 3    for ix, enemy in...      │
│                      │ 4      if enemy.isDestro...   │
│ ...                  │ ...                           │
└──────────────────────┴───────────────────────────────┘
```

### Copy Code Button Implementation

Both `renderCodeBlock()` and `renderDiffBlock()` should include a "Copy Code" button:
- Positioned in top-right corner of code block
- Click copies code to clipboard
- Shows "Copied!" feedback briefly after clicking
- For diffs: copies only the new (right side) code
- Uses `navigator.clipboard.writeText()` API
- Styled to match the lesson theme (simple, unobtrusive)
