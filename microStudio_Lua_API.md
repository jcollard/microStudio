# microStudio API - Lua Version

This document provides the complete microStudio API adapted for Lua syntax. microStudio uses Fengari (Lua 5.3) as its Lua engine.

## Key Differences from microScript

When using Lua with microStudio, keep these differences in mind:

1. **Method calls**: Use `:` instead of `.` when calling object methods (e.g., `screen:clear()` not `screen.clear()`)
2. **Property access**: Use `.` for accessing properties (e.g., `screen.width`, `keyboard.A`)
3. **Comments**: Use `--` for single-line comments and `--[[ ]]--` for multi-line comments
4. **Boolean values**: For input checking, use `== 1` (e.g., `keyboard.A == 1`); otherwise use `true`/`false`
5. **Nil vs 0**: Lua uses `nil` for undefined/null values
6. **String concatenation**: Use `..` instead of `+`
7. **Logical operators**: Use `and`, `or`, `not` instead of `&&`, `||`, `!`
8. **Function definitions**: Use `function name() ... end` syntax
9. **Conditionals**: Use `if ... then ... end` syntax
10. **Loops**: Use `for`, `while` with `do ... end` blocks
11. **Tables**: Lua uses tables (key-value pairs) for both arrays and objects
12. **Array indexing**: Lua arrays start at index `1`, not `0`
13. **Iteration**: Use `for key, value in pairs(table)` or `for i, value in ipairs(array)`

---

## Display (screen)

In microStudio, the screen is represented by the predefined object `screen`. To display shapes or images, call methods on this object using the `:` operator.

### Example
```lua
screen:setColor("#FFF")
screen:fillRect(0, 0, 100, 100)
```

The code above defines the drawing color as white (`#FFF`), then draws a filled rectangle centered at coordinates (0, 0) of the screen.

### Screen Coordinates

microStudio automatically scales screen coordinates regardless of actual display resolution. By convention:
- The smallest display size (width in portrait, height in landscape) is **200**
- Origin point (0, 0) is the **center of the screen**
- The smallest dimension ranges from **-100 to +100**
- The largest dimension ranges from approximately **-178 to +178** (16:9 screen) or **-200 to +200** (2:1 screen)

---

## Color Functions

### screen:setColor(color)

Defines the color for future drawing operations.

**Parameters:**
- `color` (string): Color in RGB, hex, or other format

**Color formats:**
- `"rgb(255,255,255)"`: RGB values (0-255 for each component)
- `"#FFF"` or `"#FFFFFF"`: Hexadecimal notation

**Example:**
```lua
screen:setColor("#FF0000")  -- bright red
screen:setColor("rgb(0,255,0)")  -- green
```

### screen:clear(color)

Clears the screen (fills it with the provided color, or black if no color is provided).

**Parameters:**
- `color` (string, optional): Fill color

**Example:**
```lua
screen:clear("#000")  -- clear to black
screen:clear()  -- clear to black (default)
```

---

## Drawing Shapes

### screen:fillRect(x, y, width, height, color)

Draws a filled rectangle centered at (x, y).

**Parameters:**
- `x` (number): X coordinate of center
- `y` (number): Y coordinate of center
- `width` (number): Rectangle width
- `height` (number): Rectangle height
- `color` (string, optional): Fill color

**Example:**
```lua
screen:fillRect(0, 0, 100, 50, "#FF0000")
```

### screen:fillRoundRect(x, y, width, height, radius, color)

Draws a filled rounded rectangle.

**Parameters:**
- `x`, `y`: Center coordinates
- `width`, `height`: Dimensions
- `radius` (number): Corner radius
- `color` (string, optional): Fill color

**Example:**
```lua
screen:fillRoundRect(0, 0, 100, 50, 10, "#00FF00")
```

### screen:fillRound(x, y, width, height, color)

Draws a filled ellipse or circle.

**Parameters:**
- `x`, `y`: Center coordinates
- `width`, `height`: Dimensions
- `color` (string, optional): Fill color

**Example:**
```lua
screen:fillRound(0, 0, 80, 80, "#0000FF")
```

### screen:drawRect(x, y, width, height, color)

Draws a rectangle outline.

**Example:**
```lua
screen:drawRect(0, 0, 100, 50, "#FFFFFF")
```

### screen:drawRoundRect(x, y, width, height, radius, color)

Draws a rounded rectangle outline.

**Example:**
```lua
screen:drawRoundRect(0, 0, 100, 50, 10, "#FFFFFF")
```

### screen:drawRound(x, y, width, height, color)

Draws an ellipse or circle outline.

**Example:**
```lua
screen:drawRound(0, 0, 80, 80, "#FFFFFF")
```

### screen:drawLine(x1, y1, x2, y2, color)

Draws a line between two points.

**Parameters:**
- `x1`, `y1`: Start point
- `x2`, `y2`: End point
- `color` (string, optional): Line color

**Example:**
```lua
screen:drawLine(-50, -50, 50, 50, "#FFFFFF")
```

### screen:fillPolygon(x1, y1, x2, y2, x3, y3, ..., color)

Fills a polygon defined by coordinate points.

**Parameters:**
- Multiple coordinate pairs (x, y)
- `color` (string, optional): Fill color

**Alternative:** Can accept a table as first argument:
```lua
screen:fillPolygon({x1, y1, x2, y2, x3, y3}, color)
```

**Example:**
```lua
screen:fillPolygon(0, 50, -50, -50, 50, -50, "#FF00FF")
```

### screen:drawPolygon(x1, y1, x2, y2, x3, y3, ..., color)

Draws a polygon outline.

**Example:**
```lua
screen:drawPolygon(0, 50, -50, -50, 50, -50, "#FFFFFF")
```

### screen:drawPolyline(x1, y1, x2, y2, x3, y3, ..., color)

Same as `drawPolygon` but the path is not automatically closed.

**Example:**
```lua
screen:drawPolyline(0, 0, 50, 50, 100, 0, "#FFFFFF")
```

### screen:drawArc(x, y, radius, start_angle, end_angle, counter_clockwise, color)

Draws an arc of a circle.

**Parameters:**
- `x`, `y`: Center coordinates
- `radius` (number): Arc radius
- `start_angle` (number): Starting angle in degrees
- `end_angle` (number): Ending angle in degrees
- `counter_clockwise` (boolean): Direction of arc
- `color` (string, optional): Line color

**Example:**
```lua
screen:drawArc(0, 0, 50, 0, 90, false, "#FFFFFF")
```

### screen:fillArc(x, y, radius, start_angle, end_angle, counter_clockwise, color)

Fills an arc of a circle.

**Example:**
```lua
screen:fillArc(0, 0, 50, 0, 90, false, "#FF0000")
```

### screen:drawQuadCurve(x1, y1, cp1x, cp1y, x2, y2, ..., color)

Draws a quadratic curve.

**Parameters:**
- `x1`, `y1`: Start point
- `cp1x`, `cp1y`: Control point
- `x2`, `y2`: End point
- Can extend with more coordinates
- `color` (string, optional): Line color

**Example:**
```lua
screen:drawQuadCurve(0, -50, 50, 50, 0, 50, "#FFFFFF")
```

### screen:drawBezierCurve(x1, y1, cp1x, cp1y, cp2x, cp2y, x2, y2, ..., color)

Draws a Bezier curve.

**Parameters:**
- `x1`, `y1`: Start point
- `cp1x`, `cp1y`: First control point
- `cp2x`, `cp2y`: Second control point
- `x2`, `y2`: End point
- Can extend with more coordinates
- `color` (string, optional): Line color

**Example:**
```lua
screen:drawBezierCurve(0, -50, -50, 0, 50, 0, 0, 50, "#FFFFFF")
```

### screen:setLineWidth(width)

Sets the line width for subsequent line drawing operations.

**Parameters:**
- `width` (number): Line width (default is 1)

**Example:**
```lua
screen:setLineWidth(3)
screen:drawLine(0, 0, 50, 50)
```

### screen:setLineDash(array_of_values)

Sets the line dash style for subsequent line drawing operations.

**Parameters:**
- `array_of_values` (table): Array of positive values defining line and gap lengths

**Example:**
```lua
screen:setLineDash({2, 4})
screen:drawLine(0, 0, 100, 0)
```

---

## Sprites and Maps

### screen:drawSprite(sprite, x, y, width, height)

Draws a sprite on the screen.

**Parameters:**
- `sprite` (string): Sprite name
- `x`, `y`: Center coordinates
- `width` (number): Display width
- `height` (number, optional): Display height (auto-calculated if omitted)

**Example:**
```lua
screen:drawSprite("icon", 0, 50, 50, 50)
screen:drawSprite("icon", 0, 50, 50)  -- height auto-calculated
```

### Animated Sprites

Animated sprites automatically draw the correct frame. You can set the current frame:

```lua
sprites["sprite1"]:setFrame(0)  -- 0 is the index of the first frame
```

Draw a specific animation frame:

```lua
screen:drawSprite("sprite1.0", 0, 50, 50, 50)  -- draws frame 0
```

### screen:drawSpritePart(sprite, part_x, part_y, part_width, part_height, x, y, width, height)

Draws part of a sprite.

**Parameters:**
- `sprite` (string): Sprite name
- `part_x`, `part_y`: Top-left corner of sprite part (0,0 is sprite's top-left)
- `part_width`, `part_height`: Size of sprite part
- `x`, `y`: Center coordinates for display
- `width`, `height`: Display dimensions

**Example:**
```lua
screen:drawSpritePart("icon", 4, 4, 8, 8, 0, 50, 50, 50)
```

### screen:drawMap(map, x, y, width, height)

Draws a map on the screen.

**Parameters:**
- `map` (string): Map name
- `x`, `y`: Center coordinates
- `width`, `height`: Display dimensions

**Example:**
```lua
screen:drawMap("map1", 0, 0, 300, 200)
```

---

## Text Display

### screen:drawText(text, x, y, size, color)

Draws text on the screen.

**Parameters:**
- `text` (string): Text to display
- `x`, `y`: Center coordinates
- `size` (number): Text height
- `color` (string, optional): Text color

**Example:**
```lua
screen:drawText("Hello!", 0, 0, 30, "#FFF")
```

### screen:drawTextOutline(text, x, y, size, color)

Draws text outline. Use after `drawText` to increase contrast.

**Example:**
```lua
screen:drawText("Hello!", 0, 0, 30, "#FFF")
screen:setLineWidth(2)
screen:drawTextOutline("Hello!", 0, 0, 30, "#F00")
```

### screen:setFont(font_name)

Sets the font for future `drawText` calls.

**Parameters:**
- `font_name` (string): Name of font to use

**Available fonts:**
AESystematic, Alkhemikal, AlphaBeta, Arpegius, Awesome, BitCell, Blocktopia, Comicoro, Commodore64, DigitalDisco, Edunline, EnchantedSword, EnterCommand, Euxoi, FixedBold, GenericMobileSystem, GrapeSoda, JupiterCrash, Kapel, KiwiSoda, Litebulb8bit, LycheeSoda, MisterPixel, ModernDos, NokiaCellPhone, PearSoda, PixAntiqua, PixChicago, PixelArial, PixelOperator, Pixellari, Pixolde, PlanetaryContact, PressStart2P, RainyHearts, RetroGaming, Revolute, Romulus, Scriptorium, Squarewave, Thixel, Unbalanced, UpheavalPro, VeniceClassic, ZXSpectrum, Zepto

**Example:**
```lua
screen:setFont("BitCell")
```

**Tip:** The global variable `fonts` is an array of all available fonts.

### screen:loadFont(font_name)

Initiates font loading. Use with `screen:isFontReady`.

**Example:**
```lua
screen:loadFont("DigitalDisco")
```

### screen:isFontReady(font_name)

Returns `true` if the font is loaded and ready, `false` otherwise.

**Parameters:**
- `font_name` (string, optional): Font to check (omit to check current font)

**Example:**
```lua
if screen:isFontReady() then
  -- we can use the default font
  screen:drawText("MY TEXT", 0, 0, 50)
end

screen:loadFont("DigitalDisco")

if screen:isFontReady("DigitalDisco") then
  screen:setFont("DigitalDisco")
  screen:drawText("SOME OTHER TEXT", 0, 50, 20)
end
```

### screen:textWidth(text, size)

Returns the width of the text when drawn with the given size.

**Example:**
```lua
local width = screen:textWidth("My Text", 20)
```

---

## Drawing Parameters

### screen:setAlpha(alpha)

Sets the overall opacity for subsequent drawing operations.

**Parameters:**
- `alpha` (number): Opacity level (0 = fully transparent, 1 = fully opaque)

**Example:**
```lua
screen:setAlpha(0.5)  -- semi-transparent
-- draw something
screen:setAlpha(1)  -- reset to fully opaque
```

### screen:setLinearGradient(x1, y1, x2, y2, color1, color2)

Sets the drawing color as a linear gradient.

**Parameters:**
- `x1`, `y1`: Starting point of gradient
- `x2`, `y2`: Ending point of gradient
- `color1` (string): Starting color
- `color2` (string): Ending color

**Example:**
```lua
screen:setLinearGradient(0, 100, 0, -100, "#FFF", "#F00")
screen:fillRect(0, 0, screen.width, screen.height)
```

### screen:setRadialGradient(x, y, radius, color1, color2)

Sets the drawing color as a radial gradient.

**Parameters:**
- `x`, `y`: Center of gradient
- `radius` (number): Gradient radius
- `color1` (string): Center color
- `color2` (string): Edge color

**Example:**
```lua
screen:setRadialGradient(0, 0, 100, "#FFF", "#F00")
screen:fillRect(0, 0, screen.width, screen.height)
```

### screen:setTranslation(tx, ty)

Translates screen coordinates for subsequent drawing operations.

**Parameters:**
- `tx`, `ty`: Translation offset

**Example:**
```lua
screen:setTranslation(50, 50)
screen:fillRect(0, 0, 20, 20)  -- drawn at (50, 50)
screen:setTranslation(0, 0)  -- reset
```

### screen:setRotation(angle)

Rotates screen coordinates for subsequent drawing operations.

**Parameters:**
- `angle` (number): Rotation angle in degrees

**Example:**
```lua
screen:setRotation(45)
-- draw something rotated
screen:setRotation(0)  -- reset
```

### screen:setScale(x, y)

Scales screen coordinates for subsequent drawing operations.

**Parameters:**
- `x`, `y`: Scale factors

**Example:**
```lua
screen:setScale(2, 2)  -- everything drawn twice as large
-- draw something
screen:setScale(1, 1)  -- reset
```

### screen:setDrawRotation(angle)

Sets rotation angle for individual drawing operations.

**Parameters:**
- `angle` (number): Rotation angle in degrees

**Example:**
```lua
screen:setDrawRotation(45)
screen:drawSprite("icon", 0, 0, 100)
screen:setDrawRotation(0)  -- reset
```

### screen:setDrawScale(x, y)

Sets scale factor for individual drawing operations.

**Parameters:**
- `x`, `y`: Scale factors (use -1 to flip)

**Example:**
```lua
screen:setDrawScale(1, -1)  -- flip vertically
screen:drawSprite("icon", 0, 0, 100)
screen:setDrawScale(1, 1)  -- reset
```

### screen:setDrawAnchor(anchor_x, anchor_y)

Sets the anchor point for drawing operations.

**Parameters:**
- `anchor_x` (number): Horizontal anchor (-1 = left, 0 = center, 1 = right)
- `anchor_y` (number): Vertical anchor (-1 = bottom, 0 = center, 1 = top)

**Example:**
```lua
screen:setDrawAnchor(-1, 0)  -- align left
screen:setDrawAnchor(-1, -1)  -- bottom left corner
screen:setDrawAnchor(0, 0)  -- center (default)
```

### screen:setBlending(blending)

Sets how subsequent drawing operations are composed with the underlying image.

**Parameters:**
- `blending` (string): Blending mode ("normal", "additive", or HTML5 Canvas composite operations)

**Example:**
```lua
screen:setBlending("additive")
```

For reference on HTML5 Canvas compositing modes, see: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/globalCompositeOperation

---

## Screen Properties

### screen.width

Current screen width (always 200 if in portrait mode). Note: This is a property, use `.` not `:`

**Example:**
```lua
local w = screen.width
```

### screen.height

Current screen height (always 200 if in landscape mode). Note: This is a property, use `.` not `:`

**Example:**
```lua
local h = screen.height
```

### screen:setCursorVisible(visible)

Shows or hides the mouse cursor.

**Parameters:**
- `visible` (boolean): `true` to show, `false` to hide

**Example:**
```lua
screen:setCursorVisible(false)
```

---

## Inputs and Controls

### system.inputs

Provides information about available input methods. Note: Properties use `.` not `:`

| Field | Value |
|-------|-------|
| `system.inputs.keyboard` | `1` if physical keyboard available, `0` otherwise |
| `system.inputs.mouse` | `1` if mouse available, `0` otherwise |
| `system.inputs.touch` | `1` if touch screen available, `0` otherwise |
| `system.inputs.gamepad` | `1` if at least 1 gamepad connected, `0` otherwise |

---

## Keyboard Inputs

Test keyboard inputs using the `keyboard` object. Note: Input properties use `.` not `:`

**Example:**
```lua
if keyboard.A == 1 then
  -- the A key is currently pressed
end
```

**Note:** Click in the execution window first to receive keyboard events.

### Display All Pressed Keys

```lua
draw = function()
  screen:clear()
  local y = 80
  for key, value in pairs(keyboard) do
    if value then
      screen:drawText(key, 0, y, 15, "#FFF")
      y = y - 20
    end
  end
end
```

**Generic codes:** `UP`, `DOWN`, `LEFT`, `RIGHT` work for arrow keys and ZQSD/WASD.

**Special characters:** Use bracket notation:
```lua
keyboard["("]
keyboard["-"]
keyboard["+"]
```

### keyboard.press

Check if a key was just pressed (use in `update()` function):

```lua
if keyboard.press.A then
  -- Do something once when A is pressed
end
```

### keyboard.release

Check if a key was just released (use in `update()` function):

```lua
if keyboard.release.A then
  -- Do something once when A is released
end
```

---

## Touch Inputs

Test touch inputs with the `touch` object. Note: Properties use `.` not `:`

| Field | Description |
|-------|-------------|
| `touch.touching` | `true` if user is touching the screen |
| `touch.x` | X position where screen is touched |
| `touch.y` | Y position where screen is touched |
| `touch.touches` | List of currently active touch points |
| `touch.press` | `true` if finger just started touching |
| `touch.release` | `true` if finger just left the screen |

**Example:**
```lua
if touch.touching then
  -- user is touching the screen
else
  -- user is not touching the screen
end
```

### Multiple Touch Points

```lua
draw = function()
  for i, t in ipairs(touch.touches) do
    screen:drawSprite("icon", t.x, t.y, 50)
  end
end
```

---

## Mouse Inputs

Test mouse inputs with the `mouse` object. Note: Properties use `.` not `:`

| Field | Description |
|-------|-------------|
| `mouse.x` | X position of mouse pointer |
| `mouse.y` | Y position of mouse pointer |
| `mouse.pressed` | `1` if any mouse button pressed |
| `mouse.left` | `1` if left button pressed |
| `mouse.right` | `1` if right button pressed |
| `mouse.middle` | `1` if middle button pressed |
| `mouse.press` | `true` if button was just pressed |
| `mouse.release` | `true` if button was just released |

---

## Gamepad Inputs

Test gamepad buttons and joysticks with the `gamepad` object. Note: Properties use `.` not `:`

**Example:**
```lua
if gamepad.UP then
  y = y + 1
end
```

**Tip:** Type `gamepad` in the console to see all available fields.

### gamepad.press / gamepad.release

```lua
if gamepad.press.A then
  -- Button A was just pressed
end

if gamepad.release.B then
  -- Button B was just released
end
```

---

## Audio

### audio:playSound(name, volume, pitch, pan, loop)

Plays a sound with optional playback settings.

**Parameters:**
- `name` (string): Sound name from project
- `volume` (number, optional): Output volume (0 to 1)
- `pitch` (number, optional): Playback pitch (1 is default)
- `pan` (number, optional): Pan setting (-1 left to 1 right)
- `loop` (number/boolean, optional): Set to `1` or `true` for infinite loop

**Returns:** Sound control object

**Example:**
```lua
local my_sound = audio:playSound("soundname")
my_sound:setVolume(0.5)
```

### Sound Control Methods

Use `:` for methods on the returned sound object:

| Method | Description |
|--------|-------------|
| `my_sound:setVolume(volume)` | Changes playback volume (0 to 1) |
| `my_sound:setPitch(pitch)` | Changes pitch (1 is default) |
| `my_sound:setPan(pan)` | Changes pan (-1 to 1) |
| `my_sound:stop()` | Stops playback |

### audio:playMusic(name, volume, loop)

Plays music with optional playback settings.

**Parameters:**
- `name` (string): Music name from project
- `volume` (number, optional): Output volume (0 to 1)
- `loop` (number/boolean, optional): Set to `1` or `true` for infinite loop

**Returns:** Music control object

**Example:**
```lua
local my_music = audio:playMusic("musicname")
my_music:setVolume(0.5)
```

### Music Control Methods

Use `:` for methods on the returned music object:

| Method | Description |
|--------|-------------|
| `my_music:setVolume(volume)` | Changes playback volume (0 to 1) |
| `my_music:stop()` | Stops playback |
| `my_music:play()` | Resumes playback |
| `my_music:getPosition()` | Returns current position in seconds |
| `my_music:getDuration()` | Returns total duration in seconds |

### audio:beep(description)

Plays a sound described by a string.

**Example:**
```lua
audio:beep("C E G")
```

### Beep Command Reference

```lua
audio:beep("saw duration 100 span 50 duration 500 volume 50 span 50 loop 4 C2 C F G G G F end")
```

| Command | Description |
|---------|-------------|
| `saw` | Sound generator type: `saw`, `sine`, `square`, `noise` |
| `duration` | Duration of notes in milliseconds |
| `tempo` | Notes per minute |
| `span` | Percentage (1-100) of note sustain |
| `volume` | Volume (0-100) |
| `C`, `D`, `E`, etc. | Note to play (e.g., `C5` for C in 5th octave) |
| `loop` | Number of repetitions (0 = infinite); ends with `end` keyword |

### audio:cancelBeeps()

Cancels all beeper sounds.

**Example:**
```lua
audio:cancelBeeps()
```

---

## Sprites

Access project sprites via the `sprites` object. Properties use `.`, methods use `:`

```lua
local mysprite = sprites["icon"]
```

### Sprite Properties and Methods

| Field/Method | Description |
|--------------|-------------|
| `mysprite.width` | Sprite width in pixels (property, use `.`) |
| `mysprite.height` | Sprite height in pixels (property, use `.`) |
| `mysprite.ready` | `1` when fully loaded, `0` otherwise (property, use `.`) |
| `mysprite.name` | Name of the sprite (property, use `.`) |

---

## Maps

Access project maps via the `maps` object. Properties use `.`, methods use `:`

```lua
local mymap = maps["map1"]
```

### Map Properties and Methods

| Field/Method | Description |
|--------------|-------------|
| `mymap.width` | Map width in cells (property, use `.`) |
| `mymap.height` | Map height in cells (property, use `.`) |
| `mymap.block_width` | Cell width in pixels (property, use `.`) |
| `mymap.block_height` | Cell height in pixels (property, use `.`) |
| `mymap.ready` | `1` when fully loaded, `0` otherwise (property, use `.`) |
| `mymap.name` | Name of the map (property, use `.`) |
| `mymap:get(x, y)` | Returns sprite name at cell (x, y); origin (0, 0) is bottom-left; returns `0` if empty (method, use `:`) |
| `mymap:set(x, y, name)` | Sets sprite in cell (x, y); third parameter is sprite name (method, use `:`) |
| `mymap:clone()` | Returns a full copy of the map (method, use `:`) |

**Example:**
```lua
local sprite_name = mymap:get(5, 3)
mymap:set(5, 3, "newsprite")
local map_copy = mymap:clone()
```

---

## Assets

The asset manager allows importing various file types:

- `.TTF`: Font files
- `.JSON`: Structured data (loaded as Lua table)
- `.GLB`, `.OBJ`: 3D models (Babylon.js or micro3D only)
- `.TXT`: Plain text files
- `.CSV`: Comma-separated values

**Note:** Enable the Assets tab in project options.

### Loading Assets

Assets must be loaded from code. Loading is asynchronous with two methods to check completion:

1. **Callback function**: Called when asset loads
2. **Loader object**: Check `.ready` property

### asset_manager:loadFont(path)

Loads a font asset.

**Example:**
```lua
asset_manager:loadFont("myfolder/myfont")

if screen:isFontReady("myfont") then
  screen:setFont("myfont")
end
```

### asset_manager:loadJSON(path, callback)

Loads a JSON file as a Lua table.

**Example with callback:**
```lua
asset_manager:loadJSON("somefolder/myjsonfile", function(data)
  myobject = data
end)
```

**Example with loader object:**
```lua
local loader = asset_manager:loadJSON("somefolder/myjsonfile")

-- Later in code
if loader.ready then
  myobject = loader.data
end
```

### asset_manager:loadText(path, callback)

Loads a text file as a string.

**Example with callback:**
```lua
asset_manager:loadText("somefolder/mytextfile", function(text)
  mytext = text
end)
```

**Example with loader object:**
```lua
local loader = asset_manager:loadText("somefolder/mytextfile")

if loader.ready then
  mytext = loader.text
end
```

### asset_manager:loadCSV(path, callback)

Loads a CSV file as a string (parsing must be done manually).

**Example:**
```lua
asset_manager:loadCSV("somefolder/mycsvfile", function(text)
  mytext = text
end)
```

### asset_manager:loadMarkdown(path, callback)

Loads a Markdown file as a string.

**Example:**
```lua
local loader = asset_manager:loadMarkdown("somefolder/mymdfile")

if loader.ready then
  mytext = loader.text
end
```

### asset_manager:loadModel(path, callback)

Loads a 3D model (Babylon.js or micro3D only).

**Example with callback:**
```lua
asset_manager:loadModel("somefolder/mymodelfile", function(container)
  container:addAllToScene()
end)
```

**Example with loader object:**
```lua
local loader = asset_manager:loadModel("somefolder/mymodelfile")

if loader.ready then
  loader.container:addAllToScene()
end
```

### asset_manager:wasmInstance(path, callback)

Creates a WebAssembly module instance.

**Example with callback:**
```lua
asset_manager:wasmInstance("somefolder/wasm_module", function(instance)
  local add = instance.exports.add
  print(add(2, 3))
end)
```

**Example with loader object:**
```lua
local loader = asset_manager:wasmInstance("somefolder/wasm_module")

if loader.ready then
  local add = loader.instance.exports.add
  print(add(4, 5))
end
```

---

## System

The `system` object provides general system information and execution control. Properties use `.`, methods use `:`

### System Information

#### system.inputs

Information about available input methods (see Inputs section above). Properties use `.`

#### system.language

User's preferred language. Property uses `.`

**Example:**
```lua
local lang = system.language
```

#### system.fps

Current effective frame rate. Property uses `.`

**Example:**
```lua
local fps = system.fps
```

### Prompts

#### system:say(message)

Displays a text message in a window.

**Example:**
```lua
system:say("Hello, world!")
```

#### system:prompt(message, callback)

Asks user to input text.

**Parameters:**
- `message` (string): Prompt message
- `callback` (function): Called with `callback(ok, text)`
  - `ok`: `1` if user validated, `0` otherwise
  - `text`: User's input text

**Example:**
```lua
system:prompt("Enter your name:", function(ok, text)
  if ok == 1 then
    print("Hello, " .. text)
  end
end)
```

### Execution Control

#### system:pause()

Pauses program execution (only works in microStudio development environment).

**Example:**
```lua
system:pause()
```

#### system:exit()

Exits the program.

**Example:**
```lua
system:exit()
```

### Time

#### system:time()

Returns elapsed time in milliseconds since January 1, 1970.

**Example:**
```lua
local current_time = system:time()
```

---

## Storage

The `storage` object allows permanent data storage for user progress, high scores, etc. Methods use `:`

### storage:set(name, value)

Stores a value permanently under the given name.

**Parameters:**
- `name` (string): Reference key
- `value`: Any number, string, table, or structured object

**Example:**
```lua
storage:set("highscore", 1000)
storage:set("player_data", {name = "Player1", level = 5})
```

### storage:get(name)

Retrieves a permanently stored value.

**Parameters:**
- `name` (string): Reference key

**Returns:** Stored value, or `0` if no record exists

**Example:**
```lua
local highscore = storage:get("highscore")
local player_data = storage:get("player_data")
```

---

## Lua-Specific Notes

### Method Calls vs Property Access

**CRITICAL:** In Lua with microStudio:
- Use `:` (colon) for **method calls**: `screen:clear()`, `audio:playSound()`, `storage:get()`
- Use `.` (dot) for **property access**: `screen.width`, `keyboard.A`, `mouse.x`

```lua
-- CORRECT
screen:clear()           -- Method call
local w = screen.width   -- Property access

-- WRONG
screen.clear()           -- Will not work!
local w = screen:width   -- Will not work!
```

### Checking User Inputs

User input fields can have 3 different statuses in Lua:
- `1`: Input is active (key pressed, button held, etc.)
- `0`: Input is inactive
- `nil`: Input doesn't exist

Always check with `== 1`:
```lua
if keyboard.LEFT == 1 then
  x = x - 1
end
```

### Array Indexing

**IMPORTANT:** Lua arrays start at index `1`, not `0`. However, microStudio map coordinates still use `0` as the origin for the bottom-left cell.

```lua
local my_array = {10, 20, 30}
print(my_array[1])  -- prints 10 (first element)
```

### Iterating Tables

Use `pairs()` for key-value iteration:

```lua
for key, value in pairs(keyboard) do
  if value then
    print(key)
  end
end
```

Use `ipairs()` for indexed array iteration:

```lua
for i, touch_point in ipairs(touch.touches) do
  screen:drawSprite("icon", touch_point.x, touch_point.y, 50)
end
```

### String Concatenation

Use `..` operator:

```lua
local message = "Score: " .. score
local full_name = first_name .. " " .. last_name
```

### Logical Operators

```lua
if player.x > 0 and player.y > 0 then
  -- both conditions true
end

if enemy.alive or enemy.respawning then
  -- at least one condition true
end

if not game_over then
  -- game_over is false
end
```

### Function Definitions

```lua
function update()
  -- game update logic
end

function draw()
  -- rendering logic
end

-- Local function
local function calculate_distance(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
```

### Conditionals

```lua
if score > 100 then
  print("High score!")
elseif score > 50 then
  print("Good score!")
else
  print("Keep trying!")
end
```

### Loops

```lua
-- For loop
for i = 1, 10 do
  print(i)
end

-- While loop
while player.health > 0 do
  -- game logic
end

-- Repeat-until loop
repeat
  -- code
until condition
```

### Comments

```lua
-- This is a single-line comment

--[[
  This is a
  multi-line comment
]]--
```

---

## Complete Example Program (Lua)

```lua
-- Initialize function (called once at start)
init = function()
  x = 0
  y = 0
end

-- Update function (called 60 times per second)
update = function()
  if keyboard.LEFT == 1 then x = x - 1 end
  if keyboard.RIGHT == 1 then x = x + 1 end
  if keyboard.UP == 1 then y = y + 1 end
  if keyboard.DOWN == 1 then y = y - 1 end
end

-- Draw function (called after update)
draw = function()
  screen:clear()
  screen:drawSprite("icon", x, y, 50)
end
```

---

## Summary of Key Lua Syntax Changes

| Feature | microScript | Lua |
|---------|-------------|-----|
| Method calls | `screen.clear()` | `screen:clear()` |
| Property access | `screen.width` | `screen.width` |
| Input checking | `if keyboard.A` | `if keyboard.A == 1 then` |
| Conditionals | `if condition` | `if condition then` |
| For loop (list) | `for i in list` | `for i, value in ipairs(list) do` |
| For loop (object) | `for key in object` | `for key, value in pairs(object) do` |
| Array indexing | `array[0]` | `array[1]` (1-indexed) |
| String concat | `"string" + "concat"` | `"string" .. "concat"` |
| Comments | `// comment` | `-- comment` |
| Boolean true | `1` or `true` | Use `== 1` for inputs, `true` otherwise |
| Boolean false | `0` or `false` | Use `== 0` or `not` |
| Nil/undefined | `0` or `null` | `nil` |

---

*This document covers the complete microStudio API adapted for Lua syntax. For the latest updates, visit https://microstudio.dev/documentation/*
