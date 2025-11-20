# Enemy Spawner - Implementation Task List

## Project Status: Implementation in Progress 🚧

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
- [ ] **CHECKPOINT: Get approval before proceeding to Step 2**

### Step 2: Create spawn_enemy() Function
- [ ] Create `steps/step2.html`
  - [ ] Intro: Dynamic spawning concept
  - [ ] Info box explaining the concept
  - [ ] Task description
  - [ ] Code block using `renderCodeBlock()` with spawn_enemy() implementation
  - [ ] Testing section with console commands
  - [ ] Demo placeholder (likely include - visual output)
  - [ ] Key teaching moment box
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
- [ ] Step 3: Verify code block renders correctly
- [ ] Step 4: Verify diff block shows changes clearly
- [ ] Step 5: Verify code block renders correctly
- [ ] Step 6: Verify diff block shows changes clearly
- [ ] Step 7: Verify code block renders correctly
- [ ] Step 8: Verify diff block shows changes clearly
- [ ] Step 9: Verify all content loads, demo iframe works

### Navigation Testing
- [ ] Test step navigation (0 through 9)
- [ ] Verify step loading mechanism works
- [ ] Check that `<script>` tags execute after loading
- [ ] Verify all code rendering functions work in each step
- [ ] Test copy buttons in all code blocks and diffs

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

- [ ] All 10 step HTML files created and tested
- [ ] index.html created with working navigation
- [ ] styles.css created with professional styling
- [ ] All code blocks and diffs render correctly
- [ ] All copy buttons work
- [ ] Navigation between steps works smoothly
- [ ] Responsive design verified
- [ ] Demo URLs provided or placeholders removed
- [ ] User has approved final implementation
- [ ] Ready for student testing

---

## Notes

**Current Phase**: Pre-Implementation (awaiting PLAN.md approval)

**Next Action**: Get user approval on PLAN.md before starting implementation

**Implementation Strategy**:
1. Create index.html and styles.css first
2. Implement steps sequentially (0→9)
3. Stop after each step for feedback
4. Test thoroughly before moving forward
5. Maintain consistent style and quality

**Key Reminders**:
- Professional, mature design for high school students
- No "kiddy" styling or excessive emojis
- Clear, concise technical explanations
- Stop and get feedback after each step
- Test code rendering functions in each step
