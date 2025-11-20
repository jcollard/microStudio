# Enemy Spawner - Implementation Task List

## Project Status: Implementation in Progress 🚧

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
- [ ] Create `kenney-sprites/` subdirectory (for Step 2b)
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
- [ ] **UPDATE `index.html` for Step 2b**:
  - [ ] Replace integer-based step tracking with array-based tracking
  - [ ] Define `steps` array: `['step0', 'step1', 'step2', 'step2b', 'step3', ...]`
  - [ ] Update `loadStep()` to use array lookup: `steps[stepIndex]`
  - [ ] Add sprite gallery button to navigation bar
  - [ ] Include `sprite-gallery.js` and `sprite-gallery.css` in head

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

- [ ] **UPDATE `codeblocks.js` for Step 2b**:
  - [ ] Add `options` parameter to `renderCodeBlock(elementId, code, language, options)`
  - [ ] Implement `options.copyable` (default: true) - hide copy button when false
  - [ ] Implement `options.selectable` (default: true) - add `.code-non-selectable` class when false
  - [ ] Add visual indicator for non-copyable code blocks

- [ ] **UPDATE `codeblocks.css` for Step 2b**:
  - [ ] Add `.code-non-selectable` class with `user-select: none`
  - [ ] Style non-copyable code blocks (subtle border or label)

- [ ] **CREATE `sprite-gallery.js`**:
  - [ ] Implement `showGallery()` function to open modal
  - [ ] Index PNG files from `kenney-sprites/` directory (hardcoded array)
  - [ ] Render sprite grid with thumbnails and filenames
  - [ ] Implement rotation controls (90° CW/CCW)
  - [ ] Canvas-based sprite rotation function
  - [ ] Download rotated sprite as PNG functionality
  - [ ] Close modal functionality

- [ ] **CREATE `sprite-gallery.css`**:
  - [ ] Modal overlay styles (fixed position, dark background)
  - [ ] Gallery container styles (centered, scrollable)
  - [ ] Sprite grid layout (CSS Grid, 4-6 columns, responsive)
  - [ ] Sprite card styles (thumbnail, filename, buttons)
  - [ ] Rotation control button styles
  - [ ] Download button styles
  - [ ] Dark theme matching lesson aesthetics
  - [ ] Close button and modal controls

- [ ] **CREATE `kenney-sprites/` directory**:
  - [ ] Add PNG sprite files from Kenney asset packs
  - [ ] Document sprite filenames for gallery indexing

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

### Step 2: Create spawn_enemy() Function
- [x] Create `steps/step2.html`
  - [x] Intro: Dynamic spawning concept
  - [x] Info box explaining the concept
  - [x] Task description
  - [x] Code block using `renderCodeBlock()` with spawn_enemy() implementation
  - [x] Testing section with console commands
  - [x] Remove demo section (console testing only)
  - [x] Key teaching moment box
- [x] Create `solutions/step2_solution.lua`
- [ ] **CHECKPOINT: Get approval before proceeding to Step 2b**

### Step 2b: CHALLENGE - Randomize Enemy Properties
- [ ] Create `steps/step2b.html`
  - [ ] Intro: Challenge step explanation (no copy-paste)
  - [ ] Info box explaining challenge format and sprite gallery
  - [ ] Task description with 3 sub-tasks:
    - [ ] Randomize enemy.vy velocity
    - [ ] Randomize enemy width/height
    - [ ] Randomize sprite selection
  - [ ] **Non-copyable code blocks** using `renderCodeBlock()` with `{copyable: false, selectable: false}`
  - [ ] Sprite gallery usage instructions
  - [ ] Hints section (not full solutions)
  - [ ] Testing section with console commands
  - [ ] Remove demo section (console testing only)
  - [ ] Key teaching moment box (active learning, typing code)
- [ ] Create `solutions/step2b_solution.lua`
- [ ] **CHECKPOINT: Get approval before proceeding to Step 3**

### Step 3: Replace init_enemies()
- [ ] Create `steps/step3.html`
  - [ ] Intro: Using spawn function for initialization
  - [ ] Info box explaining reuse of spawning function
  - [ ] Task description
  - [ ] Code block using `renderCodeBlock()` with updated init_enemies()
  - [ ] Testing instructions
  - [ ] Demo placeholder (likely include - visual output)
  - [ ] Key teaching moment box
- [ ] **CHECKPOINT: Get approval before proceeding to Step 4**

### Step 4: Object Pooling Optimization
- [ ] Create `steps/step4.html`
  - [ ] Intro: Object pooling concept
  - [ ] Info box explaining the problem and solution
  - [ ] Task description with detailed steps
  - [ ] **Diff block** using `renderDiffBlock()` showing old vs new spawn_enemy()
  - [ ] Testing section with console commands
  - [ ] Remove demo section (no visual change)
  - [ ] Key teaching moment box (professional optimization technique)
- [ ] **CHECKPOINT: Get approval before proceeding to Step 5**

### Step 5: Create all_enemies_destroyed()
- [ ] Create `steps/step5.html`
  - [ ] Intro: State checking concept
  - [ ] Info box explaining boolean functions
  - [ ] Task description
  - [ ] Code block using `renderCodeBlock()` with all_enemies_destroyed()
  - [ ] Testing section with console commands
  - [ ] Remove demo section (no visual output)
  - [ ] Key teaching moment box (state checking pattern)
- [ ] **CHECKPOINT: Get approval before proceeding to Step 6**

### Step 6: Auto-spawn After All Destroyed
- [ ] Create `steps/step6.html`
  - [ ] Intro: Event-driven gameplay
  - [ ] Info box explaining reactive systems
  - [ ] Task description
  - [ ] **Diff block** using `renderDiffBlock()` showing update_enemies() changes
  - [ ] Testing instructions
  - [ ] Demo placeholder (likely include - visible auto-spawning)
  - [ ] Key teaching moment box
- [ ] **CHECKPOINT: Get approval before proceeding to Step 7**

### Step 7: Create spawn_enemy_wave()
- [ ] Create `steps/step7.html`
  - [ ] Intro: Wave mechanics and escalating difficulty
  - [ ] Info box explaining wave formula
  - [ ] Task description with traditional for loop explanation
  - [ ] Code block using `renderCodeBlock()` with spawn_enemy_wave()
  - [ ] Testing section with console commands
  - [ ] Remove demo section (test via console)
  - [ ] Key teaching moment box (traditional for loops, #enemies)
- [ ] **CHECKPOINT: Get approval before proceeding to Step 8**

### Step 8: Implement Wave System
- [ ] Create `steps/step8.html`
  - [ ] Intro: Replace single spawn with wave spawn
  - [ ] Info box explaining impact of small change
  - [ ] Task description
  - [ ] **Diff block** using `renderDiffBlock()` showing spawn_enemy() → spawn_enemy_wave()
  - [ ] Testing instructions (play through multiple waves)
  - [ ] Demo placeholder (likely include - visible wave system)
  - [ ] Key teaching moment box
- [ ] **CHECKPOINT: Get approval before proceeding to Step 9**

### Step 9: Congratulations
- [ ] Create `steps/step9.html`
  - [ ] Celebration heading
  - [ ] What students learned (checklist)
  - [ ] Real game development connection
  - [ ] What's next preview (collision detection lesson)
  - [ ] Embedded demo of completed project (same as Step 0)
  - [ ] Encouragement and next steps
- [ ] **CHECKPOINT: Get approval - all steps complete**

---

## Testing & Verification Tasks

### Individual Step Testing
- [ ] Step 0: Verify all content loads, demo iframe works
- [ ] Step 1: Verify requirements display correctly
- [ ] Step 2: Verify code block renders with syntax highlighting
- [ ] **Step 2b: Verify non-copyable code blocks work, sprite gallery instructions clear**
- [ ] Step 3: Verify code block renders correctly
- [ ] Step 4: Verify diff block shows changes clearly
- [ ] Step 5: Verify code block renders correctly
- [ ] Step 6: Verify diff block shows changes clearly
- [ ] Step 7: Verify code block renders correctly
- [ ] Step 8: Verify diff block shows changes clearly
- [ ] Step 9: Verify all content loads, demo iframe works

### Navigation Testing
- [ ] Test step navigation (0 through 2b, 3-9) using array-based tracking
- [ ] Verify step loading mechanism works with step names (not just integers)
- [ ] Check that `<script>` tags execute after loading
- [ ] Verify all code rendering functions work in each step
- [ ] Test copy buttons in all code blocks and diffs
- [ ] **Test non-copyable code blocks in Step 2b** (no copy button, no text selection)
- [ ] **Test sprite gallery button in navigation** - opens modal correctly

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
- [ ] Sprite gallery button opens modal
- [ ] Sprite grid displays correctly with thumbnails
- [ ] Filenames shown clearly under each sprite
- [ ] Rotation controls work (90° CW/CCW)
- [ ] Canvas-based rotation produces correct output
- [ ] Download button exports rotated PNG correctly
- [ ] Close modal functionality works
- [ ] Gallery responsive on different screen sizes

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

- [ ] All 11 step HTML files created and tested (step0-step9 + step2b)
- [ ] index.html updated with array-based step tracking
- [ ] styles.css created with professional styling
- [ ] codeblocks.js updated with copyable/selectable options
- [ ] sprite-gallery.js created and functional
- [ ] sprite-gallery.css created matching lesson theme
- [ ] kenney-sprites/ directory populated with PNG assets
- [ ] All code blocks and diffs render correctly
- [ ] All copy buttons work (except in Step 2b challenge)
- [ ] Non-copyable code blocks work in Step 2b
- [ ] Sprite gallery functional and integrated in navigation
- [ ] Navigation between steps works smoothly with array tracking
- [ ] Responsive design verified
- [ ] Demo URLs provided or placeholders removed
- [ ] All solution files created (including step2b_solution.lua)
- [ ] User has approved final implementation
- [ ] Ready for student testing

---

## Notes

**Current Phase**: Step 2 Complete, awaiting approval before Step 2b

**Next Action**: Get user approval on Step 2 before proceeding to implement Step 2b features

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
