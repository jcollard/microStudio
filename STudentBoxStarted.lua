-- Helper functions - put these BEFORE init/update/draw

-- Draw a box
function draw_box(b)
  screen:setColor(b.color)
  screen:fillRect(b.x, b.y, b.size, b.size)
end

-- Function to create a new box
function create_box(x, y, size, vx, vy, color)
  local new_box = {
    x = x,
    y = y,
    size = size,
    vx = vx,
    vy = vy,
    color = color
  }
  return new_box
end

-- Update a box (move it and check boundaries)
function update_box(b)
  -- Move the box
  b.x = b.x + b.vx
  b.y = b.y + b.vy

  -- Check boundaries (same as before, but uses 'b' parameter)
  if b.x - b.size / 2 < -screen.width / 2 then
    b.x = -screen.width / 2 + b.size / 2
    b.vx = -b.vx
  end

  if b.x + b.size / 2 > screen.width / 2 then
    b.x = screen.width / 2 - b.size / 2
    b.vx = -b.vx
  end

  if b.y - b.size / 2 < -screen.height / 2 then
    b.y = -screen.height / 2 + b.size / 2
    b.vy = -b.vy
  end

  if b.y + b.size / 2 > screen.height / 2 then
    b.y = screen.height / 2 - b.size / 2
    b.vy = -b.vy
  end
end

-- Main functions

-- Initialize the box
init = function()
  -- Use our function to create boxes!
  box1 = create_box(0, 0, 20, 2, 1.5, "#FF0000")
  box2 = create_box(-50, 30, 25, -1.5, -2, "#00FF00")
end

-- Update the box position
update = function()
  update_box(box1)
  update_box(box2)
end

-- Draw the box
draw = function()
  screen:clear("#000020")
  draw_box(box1)
  draw_box(box2)
end