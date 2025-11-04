-- Helper functions - put these BEFORE init/update/draw

draw_box = function(b)
  screen.fillRound(b.x, b.y, b.size, b.size, 5, b.color)
end

create_box = function(x, y, size, vx, vy, color)
  local new_box = object
    x = x
    y = y
    size = size
    vx = vx
    vy = vy
    color = color
  end
  return new_box
end

update_box = function(b)
  b.x += b.vx
  b.y += b.vy

  -- Check if box hits left or right edge
  if b.x - b.size/2 < -screen.width/2 or b.x + b.size/2 > screen.width/2 then
    b.vx = -b.vx
  end

  -- Check if box hits top or bottom edge
  if b.y - b.size/2 < -screen.height/2 or b.y + b.size/2 > screen.height/2 then
    b.vy = -b.vy
  end
end

-- Main functions

init = function()
  box1 = create_box(0, 0, 20, 2, 1.5, "#FF0000")
  box2 = create_box(-50, 30, 25, -1.5, -2, "#00FF00")
end

update = function()
  update_box(box1)
  update_box(box2)
end

draw = function()
  screen.clear()
  draw_box(box1)
  draw_box(box2)
end
