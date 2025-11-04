-- Function to create a new box
function create_box(x, y, size, vx, vy, color)
  local new_box = {
    x = x,
    y = y,
    size = size,
    vx = vx,
    vy = vy,
    color = color,
    original_color = color
  }
  return new_box
end

-- Update a single box
function update_box(b)
  b.x = b.x + b.vx
  b.y = b.y + b.vy

  -- Bounce off walls
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

-- Draw a single box
function draw_box(b)
  screen:setColor(b.color)
  screen:fillRect(b.x, b.y, b.size, b.size)
end

-- Check if two boxes are colliding
function boxes_colliding(box_a, box_b)
  local a_left = box_a.x - box_a.size / 2
  local a_right = box_a.x + box_a.size / 2
  local a_bottom = box_a.y - box_a.size / 2
  local a_top = box_a.y + box_a.size / 2

  local b_left = box_b.x - box_b.size / 2
  local b_right = box_b.x + box_b.size / 2
  local b_bottom = box_b.y - box_b.size / 2
  local b_top = box_b.y + box_b.size / 2

  if a_right > b_left and
     a_left < b_right and
     a_top > b_bottom and
     a_bottom < b_top then
    return true
  end

  return false
end

-- Make two boxes bounce off each other
function bounce_boxes(box_a, box_b)
  if not boxes_colliding(box_a, box_b) then
    return
  end

  -- Calculate overlap on each axis
  local dx = box_b.x - box_a.x
  local dy = box_b.y - box_a.y

  -- Calculate overlap amounts
  local overlap_x = (box_a.size + box_b.size) / 2 - math.abs(dx)
  local overlap_y = (box_a.size + box_b.size) / 2 - math.abs(dy)

  -- Separate along the axis with least overlap
  if overlap_x < overlap_y then
    -- Separate horizontally
    if dx > 0 then
      box_a.x = box_a.x - overlap_x / 2
      box_b.x = box_b.x + overlap_x / 2
    else
      box_a.x = box_a.x + overlap_x / 2
      box_b.x = box_b.x - overlap_x / 2
    end
    -- Bounce horizontally
    local temp_vx = box_a.vx
    box_a.vx = box_b.vx
    box_b.vx = temp_vx
  else
    -- Separate vertically
    if dy > 0 then
      box_a.y = box_a.y - overlap_y / 2
      box_b.y = box_b.y + overlap_y / 2
    else
      box_a.y = box_a.y + overlap_y / 2
      box_b.y = box_b.y - overlap_y / 2
    end
    -- Bounce vertically
    local temp_vy = box_a.vy
    box_a.vy = box_b.vy
    box_b.vy = temp_vy
  end
end

-- Initialize with multiple boxes
init = function()
  boxes = {}

  -- Create 8 random boxes
  local colors = {"#FF0000", "#00FF00", "#0000FF", "#FF00FF",
                  "#FFFF00", "#00FFFF", "#FF8800", "#8800FF"}

  for i = 1, 8 do
    local x = (math.random() - 0.5) * screen.width * 0.8
    local y = (math.random() - 0.5) * screen.height * 0.8
    local size = math.random(15, 30)
    local vx = (math.random() - 0.5) * 3
    local vy = (math.random() - 0.5) * 3

    table.insert(boxes, create_box(x, y, size, vx, vy, colors[i]))
  end
end

-- Update all boxes
update = function()
  -- Move all boxes
  for i, box in ipairs(boxes) do
    update_box(box)
  end

  -- Check collisions between all pairs of boxes
  for i = 1, #boxes do
    boxes[i].color = boxes[i].original_color  -- Reset color

    for j = i + 1, #boxes do
      bounce_boxes(boxes[i], boxes[j])

      -- Change color if colliding
      if boxes_colliding(boxes[i], boxes[j]) then
        boxes[i].color = "#FFFFFF"
        boxes[j].color = "#FFFFFF"
      end
    end
  end
end

-- Draw all boxes
draw = function()
  screen:clear("#000020")

  for i, box in ipairs(boxes) do
    draw_box(box)
  end
end