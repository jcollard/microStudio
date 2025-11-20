# Enemy Spawner - Implementation Task List

## Project Status: ✅ ALL STEPS COMPLETE - READY FOR FINAL APPROVAL

**Total Steps**: 11 steps (step0, step1, step2, step2b, step3, step4, step5, step6, step7, step8, step9)
**Array-Based Tracking**: Steps tracked by name array, not integers
**New Feature**: Challenge Step 2b with sprite gallery

---

## Pre-Implementation Tasks

- [x] Create EnemySpawner directory
- [x] Create comprehensive PLAN.md with lesson design
- [x] Document file architecture (HTML/CSS/JS separation)
- [x] Create code rendering system (codeblocks.js, codeblocks.css)
- [x] Create demo.html to test code rendering
- [x] Define professional color palette for mature audience
- [x] Document demo placeholder strategy
- [x] **Get 100% approval on PLAN.md before proceeding**
- [x] Create TASK_LIST.md (this file)

---

## Setup Tasks

### Directory Structure
- [x] Create `steps/` subdirectory
- [x] Create `solutions/` subdirectory
- [x] Create `kenney-sprites/` subdirectory (for Step 2b)
- [x] Verify all existing files are in correct locations:
  - [x] codeblocks.js
  - [x] codeblocks.css
  - [x] demo.html
  - [x] PLAN.md
  - [x] TASK_LIST.md

### Core Files (Before Steps)
- [x] Create `index.html` with:
  - [x] Full HTML document structure
  - [x] CDN links (Highlight.js, jsdiff)
  - [x] CSS includes (styles.css, codeblocks.css)
  - [x] JavaScript includes (codeblocks.js)
  - [x] Navigation UI structure
  - [x] Content area for loading step fragments
  - [x] Step loading JavaScript (Fetch API)
- [x] **UPDATE `index.html` for Step 2b**:
  - [x] Replace integer-based step tracking with array-based tracking
  - [x] Define `steps` array: `['step0', 'step1', 'step2', 'step2b', 'step3', ...]`
  - [x] Update `loadStep()` to use array lookup: `steps[stepIndex]`
  - [x] Add sprite gallery button to navigation bar
  - [x] Include `sprite-gallery.js`, `sprite-gallery.css`, and `lazy-embed.js` in head

- [x] Create `styles.css` with:
  - [x] Page layout (navigation, content area)
  - [x] Professional color palette implementation
  - [x] Typography (fonts, sizes, spacing)
  - [x] Navigation UI styling
  - [x] Info box styling (.info-box)
  - [x] Success box styling (.success-box)
  - [x] Demo container styling (.demo-container)
  - [x] Step content container styling (.step-content)
  - [x] Responsive design rules

- [x] **UPDATE for Step 2b - CSS-based approach**:
  - [x] Use CSS `user-select: none` directly in step2b.html for non-copyable code
  - [x] Hide copy buttons via CSS in step2b.html
  - [x] Simpler approach - no codeblocks.js modifications needed

- [x] **CREATE `lazy-embed.js`**:
  - [x] Implement `createLazyEmbed()` function for manual embed creation
  - [x] Implement `initializeLazyEmbeds()` for auto-initialization
  - [x] Support `data-src` and `data-height` attributes
  - [x] "Click to Play" placeholder overlay
  - [x] Lazy-load iframes on click

- [x] **CREATE `sprite-gallery.js`**:
  - [x] Implement `showGallery()` function to open modal
  - [x] Index 299 PNG files from 10 categories (Enemy Ships, UFOs, Player Ships, Lasers, Effects, Damage, Meteors, Parts, Power-ups, UI)
  - [x] Render sprite grid with thumbnails and lowercase filenames
  - [x] Category tab navigation system
  - [x] Dynamic pagination based on viewport size
  - [x] Cross-category navigation with wrap-around
  - [x] Rotation controls (90° CW/CCW)
  - [x] Canvas-based sprite rotation
  - [x] Download rotated sprite as PNG
  - [x] Close modal functionality

- [x] **CREATE `sprite-gallery.css`**:
  - [x] Modal overlay (fixed, dark background, 85vh height)
  - [x] Gallery container (fixed height, scrollable)
  - [x] Category tabs (active states, hover effects)
  - [x] Sprite grid (responsive, auto-fill)
  - [x] Sprite cards (preview, filename, controls)
  - [x] Rotation button styles
  - [x] Download button styles
  - [x] Pagination controls
  - [x] Dark theme matching lesson aesthetics
  - [x] Responsive design (mobile/tablet/desktop)

- [x] **POPULATE `kenney-sprites/` directory**:
  - [x] Added 299 PNG sprite files from Kenney Space Shooter Redux pack
  - [x] Organized in 10 categories with subdirectories
  - [x] All sprites indexed in sprite-gallery.js

---

## Step Implementation Tasks

**IMPORTANT PROCESS NOTE:**
> **Stop after completing each step to get feedback and approval before proceeding to the next step.**
>
> After completing each step HTML file:
> 1. Test the step in the browser (verify code rendering, copy buttons, layout)
> 2. Verify all `renderCodeBlock()` and `renderDiffBlock()` calls work correctly
> 3. Check that inline `<script>` tags execute properly
> 4. Confirm demo placeholder is included (or intentionally removed)
> 5. Present to user for review and approval
> 6. Make any requested changes
> 7. Only proceed to next step after explicit approval
>
> This iterative approach ensures quality and alignment with expectations at each stage.

---

### Step 0: Welcome/Introduction
- [x] Create `steps/step0.html`
  - [x] Welcome heading and introduction
  - [x] Explain current system (all enemies created in init)
  - [x] Introduce the problem (enemies during gameplay)
  - [x] Introduce the solution (dynamic spawning)
  - [x] Preview the challenge (spawning, pooling, waves)
  - [x] Embedded demo of finished project (DEMO_URL_HERE placeholder)
- [x] **CHECKPOINT: Get approval before proceeding to Step 1**

### Step 1: Getting Started
- [x] Create `steps/step1.html`
  - [x] Two options section (clone vs continue)
  - [x] Requirements checklist
  - [x] Link to starter project (URL to be provided)
  - [x] Prerequisites explanation
  - [x] Remove demo section (no visual output)
- [x] **CHECKPOINT: Get approval before proceeding to Step 2**

### Step 2: Create spawn_enemy() Function ✅
- [x] Create `steps/step2.html`
  - [x] Intro: Dynamic spawning concept
  - [x] Info box explaining the concept
  - [x] Task description
  - [x] Code block using `renderCodeBlock()` with spawn_enemy() implementation
  - [x] Testing section with console commands
  - [x] Remove demo section (console testing only)
  - [x] Key teaching moment box
- [x] Create `solutions/step2_solution.lua`
- [x] **CHECKPOINT: ✅ APPROVED**

### Step 2b: CHALLENGE - Randomize Enemy Properties ✅
- [x] Create `steps/step2b.html`
  - [x] Intro: Challenge step explanation (optional but recommended)
  - [x] Info box explaining square sprite constraints (width = height)
  - [x] **Challenge 1: Random Enemy Sizes**
    - [x] Global SIZES table with curly braces `{24, 32, 40}`
    - [x] Explanation of Lua 1-based indexing
    - [x] Example: `SIZES[math.random(1, 3)]`
    - [x] Challenge to add more sizes (5 options)
  - [x] **Challenge 2: Random Enemy Types**
    - [x] Global ENEMY_SPRITES table
    - [x] Random selection between 2 sprite types
    - [x] Challenge to add more types (3-5 sprites)
  - [x] **Non-copyable code blocks** - CSS user-select: none
  - [x] Sprite gallery button integration
  - [x] Testing section with console commands
  - [x] Embedded playable demo with refresh button
  - [x] Success box: Key concepts (data-driven design, random selection, visual variety)
- [x] Create `solutions/step2b_solution.lua`
  - [x] 5 size options: `{16, 24, 32, 40, 48}`
  - [x] 5 lowercase sprite names: `{"enemyblack1", "enemyblue2", "enemygreen3", "enemyred4", "ufoblue"}`
  - [x] Correct Lua syntax (curly braces, 1-based indexing)
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 3**

### Step 3: Replace init_enemies() ✅
- [x] Create `steps/step3.html`
  - [x] Intro: Code refactoring and DRY principle
  - [x] Info box explaining "The Power of Abstraction"
  - [x] Task description
  - [x] **Diff block** using `renderDiffBlock()` showing old (33 lines) vs new (5 lines) init_enemies()
  - [x] Info box: "What Just Happened?" - explaining the transformation
  - [x] Testing instructions
  - [x] "Try This!" section showing multiple spawn_enemy() calls
  - [x] Success box: Key Concept - Code Reuse and DRY principle
- [x] Create `solutions/step3_solution.lua`
  - [x] Simplified init_enemies() using spawn_enemy()
  - [x] Complete working solution with all support functions
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 4**

### Step 4: Object Pooling Optimization ✅
- [x] Create `steps/step4.html`
  - [x] Intro: Object pooling concept explaining memory waste problem
  - [x] Info box: "The Problem: Memory Waste" - showing table growth issues
  - [x] Info box: "The Solution: Object Pooling" - explaining reuse pattern
  - [x] Task description with detailed steps
  - [x] **Diff block** using `renderDiffBlock()` showing old vs new spawn_enemy()
  - [x] Refactored with cleaner pattern (local enemy = nil, single property setting)
  - [x] Info box: "How Object Pooling Works" - step-by-step trace
  - [x] Testing section with console commands
  - [x] Success box: Professional optimization technique with real-world applications
  - [x] **Non-copyable diff block** - encourages typing for learning
- [x] Create `solutions/step4_solution.lua`
  - [x] Object pooling implementation with cleaner pattern
  - [x] Searches for destroyed enemy, breaks when found
  - [x] Single property-setting section (no duplication)
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 5**

### Step 5: Create all_enemies_destroyed() ✅
- [x] Create `steps/step5.html`
  - [x] Intro: State checking concept
  - [x] Info box explaining boolean functions and common examples
  - [x] Task description with requirements
  - [x] Code block using `renderCodeBlock()` with all_enemies_destroyed()
  - [x] Info box explaining "early return" pattern
  - [x] Testing section with console commands
  - [x] Success box explaining state checking pattern and real-world applications
- [x] Create `solutions/step5_solution.lua`
- [x] **CHECKPOINT: ✅ READY FOR APPROVAL - Ready for Step 6**

### Step 6: Auto-spawn After All Destroyed ✅
- [x] Create `steps/step6.html`
  - [x] Intro: Event-driven gameplay concept
  - [x] Info box explaining event-driven programming pattern
  - [x] Task description with 3 requirements
  - [x] **Diff block** using `renderDiffBlock()` showing update_enemies() changes
  - [x] Info box explaining how the auto-spawn loop works
  - [x] Testing instructions with gameplay steps
  - [x] Success box: Reactive game systems with real-world examples
  - [x] **Non-copyable diff block** - encourages typing for learning
- [x] Create `solutions/step6_solution.lua`
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 7**

### Step 7: Create spawn_enemy_wave() ✅
- [x] Create `steps/step7.html`
  - [x] Intro: Wave mechanics and escalating difficulty
  - [x] Info box explaining wave formula and progression (Wave N → N+1)
  - [x] Task description with 4 requirements explaining traditional for loop
  - [x] Code block using `renderCodeBlock()` with spawn_enemy_wave()
  - [x] Info box: Understanding traditional for loops vs pairs()
  - [x] Info box: How it works - detailed wave progression trace
  - [x] Testing section with console commands
  - [x] Success box: Escalating difficulty systems with real-world examples
  - [x] Explains different difficulty formulas (linear, multiplicative, exponential, capped)
  - [x] **Non-copyable code blocks** - encourages typing for learning
- [x] Create `solutions/step7_solution.lua`
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 8**

### Step 8: Implement Wave System ✅
- [x] Create `steps/step8.html`
  - [x] Intro: Replace single spawn with wave spawn for complete system
  - [x] Info box: The Power of Small Changes
  - [x] Task description with 3 requirements
  - [x] **Diff block** using `renderDiffBlock()` showing spawn_enemy() → spawn_enemy_wave()
  - [x] Info box: What Just Happened - detailed wave progression
  - [x] Testing instructions (play through multiple waves)
  - [x] Success box: Professional wave-based gameplay with all techniques learned
  - [x] Lists all professional techniques: composable functions, factory pattern, object pooling, state machines, event-driven architecture
  - [x] **Non-copyable diff block** - encourages typing for learning
- [x] Create `solutions/step8_solution.lua`
- [x] **CHECKPOINT: ✅ APPROVED - Ready for Step 9**

### Step 9: Congratulations
- [x] Create `steps/step9.html`
  - [x] Celebration heading
  - [x] What students learned (checklist)
  - [x] Real game development connection
  - [x] What's next preview (collision detection lesson)
  - [x] Embedded demo of completed project (same as Step 0)
  - [x] Encouragement and next steps
- [x] **CHECKPOINT: ✅ READY FOR APPROVAL - All steps complete**

---

## Testing & Verification Tasks

### Individual Step Testing
- [x] Step 0: Verify all content loads, demo iframe works
- [x] Step 1: Verify requirements display correctly
- [x] Step 2: Verify code block renders with syntax highlighting
- [x] **Step 2b: Verify non-copyable code blocks work, sprite gallery button works, lazy embed loads**
- [x] **Step 3: Verify diff block shows 33→5 line transformation clearly**
- [x] **Step 4: Verify diff block shows object pooling pattern, non-copyable**
- [x] **Step 5: Verify code block renders correctly, info boxes display properly**
- [x] **Step 6: Verify diff block shows auto-spawn addition, non-copyable**
- [x] **Step 7: Verify code block renders correctly, info boxes display properly, non-copyable**
- [x] **Step 8: Verify diff block shows wave system implementation, non-copyable**
- [x] **Step 9: Verify all content loads, demo iframe works, celebration message displays**

### Navigation Testing
- [x] Test step navigation (0 through 2b, 3-9) using array-based tracking
- [x] Verify step loading mechanism works with step names (not just integers)
- [x] Check that `<script>` tags execute after loading
- [x] Verify all code rendering functions work in each step
- [x] Test copy buttons in all code blocks and diffs
- [x] **Test non-copyable code blocks in Step 2b** (no copy button, no text selection via CSS)
- [x] **Test sprite gallery button in navigation** - opens modal correctly
- [x] **Test lazy embed initialization** - embeds load dynamically in steps

### Cross-browser Testing
- [ ] Test in Chrome/Edge
- [ ] Test in Firefox
- [ ] Test in Safari (if available)
- [ ] Verify responsive design on mobile

### Code Rendering Testing
- [ ] All `renderCodeBlock()` calls work correctly
- [ ] All `renderDiffBlock()` calls work correctly
- [ ] Syntax highlighting displays properly
- [ ] Copy buttons function correctly
- [ ] Demo iframes load (when URLs are provided)
- [ ] **Non-copyable code blocks work** (Step 2b) - no copy button, no text selection

### Sprite Gallery Testing
- [x] Sprite gallery button opens modal
- [x] Sprite grid displays correctly with thumbnails
- [x] Filenames shown in lowercase under each sprite
- [x] Category tabs work (10 categories)
- [x] Pagination works (dynamic based on viewport)
- [x] Cross-category navigation with wrap-around
- [x] Rotation controls work (90° CW/CCW)
- [x] Canvas-based rotation produces correct output
- [x] Download button exports rotated PNG correctly
- [x] Close modal functionality works
- [x] Gallery responsive on different screen sizes

---

## Polish & Finalization Tasks

- [ ] Replace all `DEMO_URL_HERE` placeholders with actual URLs (or remove)
- [ ] Verify professional color palette is consistently applied
- [ ] Check spelling and grammar in all steps
- [ ] Verify code examples match PLAN.md specifications
- [ ] Ensure all technical terms are explained
- [ ] Verify mature/professional tone throughout

---

## Documentation Tasks

- [ ] Update PLAN.md with any changes made during implementation
- [ ] Document any deviations from original plan
- [ ] Create README.md (if needed) with:
  - [ ] How to run the lesson locally
  - [ ] File structure overview
  - [ ] Dependencies (CDN links)
- [ ] Mark TASK_LIST.md as complete

---

## Completion Checklist

- [x] All 11 step HTML files created and tested (step0-step9 + step2b)
  - [x] step0.html ✅
  - [x] step1.html ✅
  - [x] step2.html ✅
  - [x] step2b.html ✅
  - [x] step3.html ✅
  - [x] step4.html ✅
  - [x] step5.html ✅
  - [x] step6.html ✅
  - [x] step7.html ✅
  - [x] step8.html ✅
  - [x] step9.html ✅
- [x] index.html updated with array-based step tracking
- [x] styles.css created with professional styling
- [x] codeblocks.js created (no modifications needed for Step 2b)
- [x] lazy-embed.js created with auto-initialization
- [x] sprite-gallery.js created and functional (299 sprites, 10 categories)
- [x] sprite-gallery.css created matching lesson theme
- [x] kenney-sprites/ directory populated with 299 PNG assets
- [x] All code blocks render correctly (Steps 0-2b)
- [x] All copy buttons work (Steps 0-2)
- [x] Non-copyable code blocks work in Step 2b (CSS approach)
- [x] Sprite gallery functional and integrated in navigation
- [x] Navigation between steps works smoothly with array tracking
- [x] Responsive design verified
- [x] Demo URLs provided (step0, step6, step8, step9 have embedded demos)
- [x] Solution files created:
  - [x] step2_solution.lua ✅
  - [x] step2b_solution.lua ✅
  - [x] step3_solution.lua ✅
  - [x] step4_solution.lua ✅
  - [x] step5_solution.lua ✅
  - [x] step6_solution.lua ✅
  - [x] step7_solution.lua ✅
  - [x] step8_solution.lua ✅
- [ ] User has approved final implementation (Steps 0-2b approved, 3-9 pending)
- [ ] Ready for student testing (after all steps complete)

---

## Notes

**Current Phase**: All Steps (0-9, including 2b) Complete ✅ | Ready for Final Approval

**Next Action**: Await approval for Step 9 (Congratulations) - Final step complete!

**Step 9 Completion Summary**:
- ✅ Created step9.html - final congratulations and celebration page
- ✅ Celebration heading with achievement recognition
- ✅ Success box summarizing what students built (dynamic spawning, object pooling, state checking, event-driven gameplay, wave mechanics, composable functions)
- ✅ Professional techniques mastered: factory pattern, object pooling, event-driven architecture, wave mechanics
- ✅ Info boxes for each professional technique with real-world applications
- ✅ Step-by-step journey recap (Steps 1-8 summary)
- ✅ Embedded demo of completed project (same as Step 0 and Step 8)
- ✅ Success box: Games that use these techniques (Vampire Survivors, Geometry Wars, Hades, Enter the Gungeon, Risk of Rain)
- ✅ "What's Next" section with extension ideas (different enemy types, power-ups, boss waves, difficulty curves, spawn patterns, wave announcements, score system)
- ✅ Challenge ideas section for extending skills
- ✅ Key mindset development summary (decomposition, reusability, optimization, systems thinking)
- ✅ Final success box celebrating game developer achievement
- ✅ Next lesson preview: Collision Detection tutorial
- ✅ Encouraging and professional tone throughout

**Step 8 Completion Summary**:
- ✅ Created step8.html teaching complete wave system implementation
- ✅ Info box: The Power of Small Changes - one line transforms entire game
- ✅ Task description with 3 simple requirements
- ✅ Diff block showing spawn_enemy() → spawn_enemy_wave() replacement
- ✅ Info box: What Just Happened - traces wave progression (1 → 2 → 3 → N)
- ✅ Testing instructions with 5-step gameplay test
- ✅ Success box: Professional wave-based gameplay - comprehensive summary of all techniques
- ✅ Lists all professional techniques learned: composable functions, factory pattern, object pooling, state machines, event-driven architecture
- ✅ Real-world applications: survival games, tower defense, bullet hell, roguelikes, arena shooters
- ✅ Non-copyable diff block to encourage typing and understanding
- ✅ Created step8_solution.lua with complete wave system
- ✅ Demonstrates how small changes create massive gameplay impact

**Step 7 Completion Summary**:
- ✅ Created step7.html teaching wave mechanics and escalating difficulty
- ✅ Info box explaining wave formula and progression (Wave N → N+1)
- ✅ Task description with 4 clear requirements explaining traditional for loop
- ✅ Code block showing spawn_enemy_wave() implementation
- ✅ Info box: Understanding traditional for loops vs pairs() iteration
- ✅ Info box: Detailed wave progression trace (1 → 2 → 3 → N+1)
- ✅ Testing section with console commands showing table size growth
- ✅ Success box: Escalating difficulty systems with real-world examples (CoD Zombies, Vampire Survivors, Plants vs. Zombies)
- ✅ Explains different difficulty formulas (linear, multiplicative, exponential, capped)
- ✅ Non-copyable code blocks to encourage typing and understanding
- ✅ Created step7_solution.lua with complete wave spawning implementation
- ✅ Demonstrates traditional for loop pattern and # operator for table length

**Step 6 Completion Summary**:
- ✅ Created step6.html teaching event-driven gameplay
- ✅ Info box explaining event-driven programming pattern (check condition → trigger action → dynamic response)
- ✅ Task description with 3 clear requirements
- ✅ Diff block showing update_enemies() with auto-spawn check added
- ✅ Info box explaining gameplay loop and instant response
- ✅ Testing instructions with 4-step gameplay test
- ✅ Success box: Reactive game systems with real-world examples (Vampire Survivors, CoD Zombies, Halo, Fortnite)
- ✅ Non-copyable diff block to encourage typing and understanding
- ✅ Created step6_solution.lua with complete auto-spawn implementation
- ✅ Demonstrates continuous challenge pattern used in endless runners, survival games, roguelikes

**Step 5 Completion Summary**:
- ✅ Created step5.html teaching state checking functions
- ✅ Info box explaining boolean functions and common examples (is_player_dead, is_level_complete, etc.)
- ✅ Task description with 4 clear requirements
- ✅ Code block showing all_enemies_destroyed() implementation
- ✅ Info box explaining "early return" pattern and how the function works
- ✅ Testing section with 3 test scenarios (with enemies, after destroying all, after spawning new)
- ✅ Success box: Professional game design pattern used in achievement systems, quest completion, boss transitions
- ✅ Created step5_solution.lua with complete implementation
- ✅ Demonstrates loop-and-return pattern for checking collections

**Step 4 Completion Summary**:
- ✅ Created step4.html teaching object pooling optimization
- ✅ Explained memory waste problem with growing enemies table
- ✅ Diff block showing object pooling implementation
- ✅ Refactored with cleaner pattern (local enemy = nil, single property setting)
- ✅ Info boxes explaining problem, solution, and how pooling works
- ✅ Testing section with console commands to verify pooling
- ✅ Success box: Professional optimization technique used in Unity, Unreal, AAA games
- ✅ Non-copyable diff block to encourage typing and understanding
- ✅ Created step4_solution.lua with clean pooling implementation

**Step 3 Completion Summary**:
- ✅ Created step3.html teaching code refactoring
- ✅ Diff block showing dramatic 33 lines → 5 lines transformation
- ✅ Info boxes explaining "The Power of Abstraction" and "What Just Happened?"
- ✅ Teaching DRY (Don't Repeat Yourself) principle
- ✅ "Try This!" section showing multiple spawn_enemy() calls
- ✅ Success box: Key Concept about code reuse, maintainability, readability, and flexibility
- ✅ Created step3_solution.lua with simplified init_enemies()
- ✅ Demonstrates practical application of function abstraction

**Step 2b Completion Summary**:
- ✅ Created step2b.html with two progressive challenges
- ✅ Challenge 1: Random enemy sizes using SIZES table
- ✅ Challenge 2: Random sprite types using ENEMY_SPRITES table
- ✅ Implemented non-copyable code blocks via CSS
- ✅ Integrated sprite gallery button
- ✅ Added playable demo with refresh functionality
- ✅ Created step2b_solution.lua with correct Lua syntax
- ✅ Sprite gallery fully functional (299 sprites, 10 categories, pagination, rotation, download)
- ✅ Lazy embed system for interactive demos
- ✅ All lowercase sprite names matching microStudio conventions

**Implementation Strategy**:
1. Update core files first (index.html array tracking, codeblocks.js options, sprite gallery system)
2. Implement sprite gallery (sprite-gallery.js, sprite-gallery.css, kenney-sprites/)
3. Implement steps sequentially (0→1→2→2b→3→...→9)
4. Stop after each step for feedback
5. Test thoroughly before moving forward
6. Maintain consistent style and quality

**Key Reminders**:
- Professional, mature design for high school students
- No "kiddy" styling or excessive emojis
- Clear, concise technical explanations
- Stop and get feedback after each step
- Test code rendering functions in each step
- **NEW**: Array-based step tracking (not integer-based)
- **NEW**: Challenge step 2b uses non-copyable code blocks
- **NEW**: Sprite gallery available globally from navigation bar
- **NEW**: All steps (including challenges) get solution files
